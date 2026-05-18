#!/usr/bin/env bash
# ====================================================================
# state.sh · CLI pra gerenciar STATE.json de um pitch
# Uso:
#   state.sh init <pasta-projeto>          # cria STATE.json
#   state.sh phase <pasta> <nome>          # marca fase como current
#   state.sh complete <pasta> <fase>       # marca fase como completed
#   state.sh approve <pasta> <gate> <by>   # registra aprovação
#   state.sh snapshot <pasta> <fase>       # cria snapshot do diretório
#   state.sh status <pasta>                # mostra estado atual
#   state.sh log <pasta> <evento>          # adiciona evento ao histórico
#   state.sh ethics-block <pasta> <razão>  # registra bloqueio ético
# ====================================================================

set -e

CMD="${1:-help}"
SKILL_PATH="$HOME/.claude/skills/proposta-comercial"
TEMPLATE="$SKILL_PATH/templates/STATE.json.template"

require_jq() {
  if ! command -v jq &> /dev/null; then
    echo "❌ jq não encontrado. Instale com: brew install jq"
    exit 1
  fi
}

now() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

case "$CMD" in
  init)
    PASTA="$2"
    NOME="${3:-Cliente}"
    URL="${4:-}"
    NICHO="${5:-}"

    [ -z "$PASTA" ] && { echo "Uso: state.sh init <pasta> <nome> [url] [nicho]"; exit 1; }
    require_jq

    mkdir -p "$PASTA"
    SLUG=$(echo "$NOME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-//;s/-$//')
    TS=$(now)

    sed -e "s|{{NOME_CLIENTE}}|$NOME|g" \
        -e "s|{{SLUG_CLIENTE}}|$SLUG|g" \
        -e "s|{{URL_CLIENTE}}|$URL|g" \
        -e "s|{{NICHO}}|$NICHO|g" \
        -e "s|{{TIMESTAMP_CREATED}}|$TS|g" \
        -e "s|{{TIMESTAMP_UPDATED}}|$TS|g" \
        -e "s|{{PATH_PROJETO}}|$PASTA|g" \
        "$TEMPLATE" > "$PASTA/STATE.json"

    mkdir -p "$PASTA/snapshots"
    echo "✓ STATE.json criado em $PASTA"
    echo "  cliente: $NOME ($SLUG)"
    echo "  fase atual: briefing"
    ;;

  phase)
    PASTA="$2"; FASE="$3"
    [ -z "$FASE" ] && { echo "Uso: state.sh phase <pasta> <nome>"; exit 1; }
    require_jq

    TS=$(now)
    jq --arg p "$FASE" --arg t "$TS" \
      '.current_phase=$p | .project.updated_at=$t | .history += [{"phase":$p,"event":"entered","at":$t}]' \
      "$PASTA/STATE.json" > "$PASTA/STATE.json.tmp"
    mv "$PASTA/STATE.json.tmp" "$PASTA/STATE.json"
    echo "→ fase atual: $FASE"
    ;;

  complete)
    PASTA="$2"; FASE="$3"
    [ -z "$FASE" ] && { echo "Uso: state.sh complete <pasta> <fase>"; exit 1; }
    require_jq

    TS=$(now)
    jq --arg p "$FASE" --arg t "$TS" \
      '.phases_completed += [$p] | .phases_completed |= unique | .project.updated_at=$t | .history += [{"phase":$p,"event":"completed","at":$t}]' \
      "$PASTA/STATE.json" > "$PASTA/STATE.json.tmp"
    mv "$PASTA/STATE.json.tmp" "$PASTA/STATE.json"
    echo "✓ fase $FASE marcada como completed"
    ;;

  approve)
    PASTA="$2"; GATE="$3"; BY="${4:-user}"; NOTES="${5:-}"
    [ -z "$GATE" ] && { echo "Uso: state.sh approve <pasta> <gate> [by] [notes]"; exit 1; }
    require_jq

    TS=$(now)
    jq --arg g "$GATE" --arg b "$BY" --arg t "$TS" --arg n "$NOTES" \
      ".approvals[\$g] = {\"approved\":true,\"by\":\$b,\"at\":\$t,\"auto\":false,\"notes\":\$n} | .project.updated_at=\$t | .history += [{\"event\":\"approved\",\"gate\":\$g,\"by\":\$b,\"at\":\$t,\"notes\":\$n}]" \
      "$PASTA/STATE.json" > "$PASTA/STATE.json.tmp"
    mv "$PASTA/STATE.json.tmp" "$PASTA/STATE.json"
    echo "✓ $GATE aprovado por $BY"
    ;;

  snapshot)
    PASTA="$2"; FASE="$3"
    [ -z "$FASE" ] && { echo "Uso: state.sh snapshot <pasta> <fase>"; exit 1; }
    require_jq

    TS=$(date -u +"%Y%m%dT%H%M%SZ")
    SNAP_DIR="$PASTA/snapshots/${FASE}-${TS}"
    mkdir -p "$SNAP_DIR"

    # Copia arquivos relevantes da fase atual
    case "$FASE" in
      briefing) [ -f "$PASTA/briefing-preenchido.md" ] && cp "$PASTA/briefing-preenchido.md" "$SNAP_DIR/" ;;
      research) [ -f "$PASTA/pesquisa-real.md" ] && cp "$PASTA/pesquisa-real.md" "$SNAP_DIR/" ;;
      strategy) [ -f "$PASTA/analise-publica.md" ] && cp "$PASTA/analise-publica.md" "$SNAP_DIR/"
                [ -f "$PASTA/analise-privada.md" ] && cp "$PASTA/analise-privada.md" "$SNAP_DIR/" ;;
      design) [ -f "$PASTA/style-tokens.css" ] && cp "$PASTA/style-tokens.css" "$SNAP_DIR/"
              [ -f "$PASTA/direcao-criativa.md" ] && cp "$PASTA/direcao-criativa.md" "$SNAP_DIR/" ;;
      copy) [ -f "$PASTA/copy-final.md" ] && cp "$PASTA/copy-final.md" "$SNAP_DIR/" ;;
      build) [ -f "$PASTA/pitch.html" ] && cp "$PASTA/pitch.html" "$SNAP_DIR/" ;;
    esac

    SNAP_PATH="snapshots/${FASE}-${TS}"
    jq --arg p "$FASE" --arg s "$SNAP_PATH" \
      ".snapshots[\$p] = \$s" \
      "$PASTA/STATE.json" > "$PASTA/STATE.json.tmp"
    mv "$PASTA/STATE.json.tmp" "$PASTA/STATE.json"
    echo "📸 snapshot $FASE → $SNAP_PATH"
    ;;

  status)
    PASTA="$2"
    [ -z "$PASTA" ] && { echo "Uso: state.sh status <pasta>"; exit 1; }
    require_jq

    if [ ! -f "$PASTA/STATE.json" ]; then
      echo "❌ STATE.json não encontrado em $PASTA"
      exit 1
    fi

    echo ""
    echo "════════════════════════════════════════════"
    jq -r '
      "🎯 \(.client.name) (\(.client.slug))",
      "   Fase atual: \(.current_phase)",
      "   Versão:     \(.project.version)",
      "   Modo:       \(.project.mode)",
      "",
      "✓ Fases concluídas:",
      (if (.phases_completed | length) > 0 then (.phases_completed[] | "    - \(.)") else "    (nenhuma ainda)" end),
      "",
      "🚦 Quality Gates:",
      "    QG1 briefing: \(if .approvals.QG1_briefing.approved then "✓" else "○" end)",
      "    QG2 research: \(if .approvals.QG2_research.approved then "✓" else "○" end)",
      "    QG3 strategy: \(if .approvals.QG3_strategy.approved then "✓" else "○" end)",
      "    QG4 design:   \(if .approvals.QG4_design.approved then "✓" else "○" end)",
      "    QG5 final:    \(if .approvals.QG5_final.approved then "✓" else "○" end)",
      "",
      (if (.ethics_blockers | length) > 0 then "🚨 BLOQUEIOS ÉTICOS:" else "" end),
      (.ethics_blockers[] | "    ⚠ \(.)" )
    ' "$PASTA/STATE.json"
    echo "════════════════════════════════════════════"
    ;;

  log)
    PASTA="$2"; EVENTO="$3"
    [ -z "$EVENTO" ] && { echo "Uso: state.sh log <pasta> <evento>"; exit 1; }
    require_jq

    TS=$(now)
    jq --arg e "$EVENTO" --arg t "$TS" \
      '.history += [{"event":$e,"at":$t}] | .project.updated_at=$t' \
      "$PASTA/STATE.json" > "$PASTA/STATE.json.tmp"
    mv "$PASTA/STATE.json.tmp" "$PASTA/STATE.json"
    ;;

  ethics-block)
    PASTA="$2"; RAZAO="$3"
    [ -z "$RAZAO" ] && { echo "Uso: state.sh ethics-block <pasta> <razão>"; exit 1; }
    require_jq

    TS=$(now)
    jq --arg r "$RAZAO" --arg t "$TS" \
      '.ethics_blockers += [$r] | .history += [{"event":"ethics_block","reason":$r,"at":$t}]' \
      "$PASTA/STATE.json" > "$PASTA/STATE.json.tmp"
    mv "$PASTA/STATE.json.tmp" "$PASTA/STATE.json"
    echo "🚨 BLOQUEIO ÉTICO registrado: $RAZAO"
    ;;

  help|--help|-h)
    sed -n '2,16p' "$0"
    ;;

  *)
    echo "Comando desconhecido: $CMD"
    echo "Use: state.sh help"
    exit 1
    ;;
esac
