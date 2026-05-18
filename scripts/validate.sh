#!/usr/bin/env bash
# ====================================================================
# validate.sh · Validador automático de pitch
# Roda os 30 critérios do CHECKLIST_QUALIDADE.md
# Bloqueia entrega se item ético falhar
#
# Uso:
#   validate.sh <pasta-projeto>
#   validate.sh <pasta> --strict       # falha em qualquer warning
#   validate.sh <pasta> --json         # output em JSON
# ====================================================================

set +e  # não sair em erro · queremos coletar TODAS as falhas

PASTA="${1:-}"
MODE="${2:-normal}"

[ -z "$PASTA" ] && { echo "Uso: validate.sh <pasta-projeto> [--strict|--json]"; exit 1; }
[ ! -d "$PASTA" ] && { echo "❌ Pasta não encontrada: $PASTA"; exit 1; }

OK=0; WARN=0; FAIL=0; ETHICAL_FAIL=0
RESULTS=()

check() {
  local code="$1"; local label="$2"; local cmd="$3"; local severity="${4:-fail}"

  if eval "$cmd" >/dev/null 2>&1; then
    RESULTS+=("✓|$code|$label|pass")
    OK=$((OK+1))
  else
    case "$severity" in
      ethical)
        RESULTS+=("🚨|$code|$label|ETHICAL_BLOCK")
        ETHICAL_FAIL=$((ETHICAL_FAIL+1))
        ;;
      warn)
        RESULTS+=("⚠|$code|$label|warn")
        WARN=$((WARN+1))
        ;;
      *)
        RESULTS+=("✗|$code|$label|fail")
        FAIL=$((FAIL+1))
        ;;
    esac
  fi
}

# ====================================================================
# BLOCO A · Briefing (5)
# ====================================================================
check "A1" "Briefing existe e completo" \
  "[ -f '$PASTA/briefing-preenchido.md' ] && [ \$(wc -l < '$PASTA/briefing-preenchido.md') -gt 50 ]"
check "A2" "Briefing tem URL/perfil do cliente" \
  "grep -qiE 'http|@[a-z]' '$PASTA/briefing-preenchido.md'"
check "A3" "Briefing tem oferta + ticket" \
  "grep -qiE 'R\\\$|EUR|USD|ticket' '$PASTA/briefing-preenchido.md'"
check "A4" "Briefing menciona regulamentação ou ausência dela" \
  "grep -qiE 'CFM|OAB|CFP|CVM|Anvisa|regulamenta|sem regulamenta' '$PASTA/briefing-preenchido.md'"
check "A5" "Briefing tem modelo de parceria" \
  "grep -qiE 'service|joint venture|equity|JV|royalty' '$PASTA/briefing-preenchido.md'"

# ====================================================================
# BLOCO B · Pesquisa (5)
# ====================================================================
check "B1" "Pesquisa real existe" \
  "[ -f '$PASTA/pesquisa-real.md' ]"
check "B2" "Pesquisa tem fontes citadas (URLs)" \
  "grep -qE 'https?://' '$PASTA/pesquisa-real.md'"
check "B3" "Pesquisa marca lacunas explicitamente" \
  "grep -qiE 'lacuna|n.o conseguid|n.o verific|sem dado' '$PASTA/pesquisa-real.md'" "warn"
check "B4" "Assets baixados (pelo menos 1 imagem)" \
  "[ -d '$PASTA/assets' ] && [ \$(find '$PASTA/assets' -type f \\( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \\) 2>/dev/null | wc -l) -gt 0 ]" "warn"
check "B5" "Paleta extraída ou marcada como ausente" \
  "grep -qiE '#[0-9a-f]{6}|paleta n.o detect' '$PASTA/pesquisa-real.md'"

# ====================================================================
# BLOCO C · Estratégia (5)
# ====================================================================
check "C1" "Análise pública existe" \
  "[ -f '$PASTA/analise-publica.md' ]"
check "C2" "Análise privada existe (matriz crítica)" \
  "[ -f '$PASTA/analise-privada.md' ]"
check "C3" "Pelo menos 6 oportunidades" \
  "grep -cE '^### #[0-9]|^### Oport|^Oportunidade [0-9]' '$PASTA/analise-publica.md' 2>/dev/null | awk '{exit (\$1<6)?1:0}'"
check "C4" "Pelo menos 6 produtos" \
  "grep -cE '^### #[0-9]|^### Produto|^Produto [0-9]' '$PASTA/analise-publica.md' 2>/dev/null | awk '{exit (\$1<6)?1:0}'"
check "C5" "Projeção tem disclaimer" \
  "grep -qiE 'conservador|estimativa|n.o garante|sem garantia' '$PASTA/analise-publica.md'"

# ====================================================================
# BLOCO D · Visual (5)
# ====================================================================
check "D1" "style-tokens.css existe" \
  "[ -f '$PASTA/style-tokens.css' ]"
check "D2" "style-tokens tem 4+ cores hex definidas" \
  "[ \$(grep -cE '#[0-9a-fA-F]{6}' '$PASTA/style-tokens.css' 2>/dev/null) -ge 4 ]"
check "D3" "style-tokens sem placeholders {{}}" \
  "! grep -q '{{' '$PASTA/style-tokens.css'"
check "D4" "Google Fonts URL no pitch.html" \
  "grep -q 'fonts.googleapis.com' '$PASTA/pitch.html'"
check "D5" "Foto/headshot do cliente disponível ou placeholder fallback" \
  "[ \$(find '$PASTA/assets' -type f \\( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.webp' \\) 2>/dev/null | wc -l) -gt 0 ] || grep -q 'bio-portrait-letter' '$PASTA/pitch.html'" "warn"

# ====================================================================
# BLOCO E · Copy (5)
# ====================================================================
check "E1" "pitch.html existe" \
  "[ -f '$PASTA/pitch.html' ]"
check "E2" "pitch.html tem os 12 slides" \
  "[ \$(grep -cE 'id=\"s[0-9]+\"' '$PASTA/pitch.html') -ge 12 ]"
check "E3" "pitch.html sem placeholders {{}}" \
  "! grep -q '{{' '$PASTA/pitch.html'"
check "E4" "CTA final menciona '30 dias' ou prazo concreto" \
  "grep -qiE '30 dias|primeiros [0-9]|em [0-9]+ semanas' '$PASTA/pitch.html'"
check "E5" "Disclaimer ético na projeção" \
  "grep -qiE 'conservador|estimativa|n.o.+garant|sem garantir' '$PASTA/pitch.html'"

# ====================================================================
# BLOCO F · Técnico (5)
# ====================================================================
check "F1" "pitch.html é HTML válido (tem <html>)" \
  "grep -q '<html' '$PASTA/pitch.html'"
check "F2" "pitch.html tem viewport meta (mobile)" \
  "grep -q 'viewport' '$PASTA/pitch.html'"
check "F3" "pitch.html tem noindex (confidencial)" \
  "grep -qE 'noindex' '$PASTA/pitch.html'"
check "F4" "Caminhos de assets são RELATIVOS (não absolutos)" \
  "! grep -qE 'src=\"/[a-z]|href=\"/[a-z]' '$PASTA/pitch.html'"
check "F5" "JS animation (IntersectionObserver) presente" \
  "grep -q 'IntersectionObserver' '$PASTA/pitch.html'"

# ====================================================================
# BLOCO ÉTICO (6 · CRÍTICOS · BLOQUEIAM ENTREGA)
# ====================================================================
check "E1-ethical" "[ÉTICO] Sem garantia de cura/resultado financeiro" \
  "! grep -qiE 'garantido|garantimos|100% certo|cura definitiva|resultado garantido|fortuna garantida|enriquece|garantia de retorno' '$PASTA/pitch.html'" "ethical"
check "E2-ethical" "[ÉTICO] Sem antes/depois (médico/estético)" \
  "! grep -qiE 'antes e depois|before.{0,3}after' '$PASTA/pitch.html'" "ethical"
check "E3-ethical" "[ÉTICO] Sem 'melhor', 'único' superlativos absolutos" \
  "! grep -qiE 'melhor m.dico|.nico no Brasil|.nico no mundo|melhor advogad|melhor consultor' '$PASTA/pitch.html'" "ethical"
check "E4-ethical" "[ÉTICO] Stats têm fonte (researcher gerou ou briefing forneceu)" \
  "[ -f '$PASTA/pesquisa-real.md' ] || [ -f '$PASTA/briefing-preenchido.md' ]" "ethical"
check "E5-ethical" "[ÉTICO] Quote do slide 03 não é genérica" \
  "! grep -qE 'O melhor de todos os tempos|melhor profissional do mundo' '$PASTA/pitch.html'" "ethical"
check "E6-ethical" "[ÉTICO] STATE.json sem ethics_blockers ativos" \
  "[ ! -f '$PASTA/STATE.json' ] || [ \$(jq '.ethics_blockers | length' '$PASTA/STATE.json' 2>/dev/null || echo 0) -eq 0 ]" "ethical"

# ====================================================================
# OUTPUT
# ====================================================================

if [ "$MODE" = "--json" ]; then
  echo "{"
  echo "  \"ok\": $OK,"
  echo "  \"warn\": $WARN,"
  echo "  \"fail\": $FAIL,"
  echo "  \"ethical_fail\": $ETHICAL_FAIL,"
  echo "  \"verdict\": \"$([ $ETHICAL_FAIL -gt 0 ] && echo BLOCKED || ([ $FAIL -gt 0 ] && echo NOT_READY || echo READY))\","
  echo "  \"results\": ["
  for i in "${!RESULTS[@]}"; do
    IFS='|' read -r icon code label status <<< "${RESULTS[$i]}"
    [ $i -gt 0 ] && echo "    ,"
    echo -n "    {\"code\":\"$code\",\"label\":\"$label\",\"status\":\"$status\"}"
  done
  echo ""
  echo "  ]"
  echo "}"
else
  echo ""
  echo "═══════════════════════════════════════════════════════"
  echo "🔍 VALIDAÇÃO · $(basename "$PASTA")"
  echo "═══════════════════════════════════════════════════════"
  echo ""

  for r in "${RESULTS[@]}"; do
    IFS='|' read -r icon code label status <<< "$r"
    printf "%s [%s] %s\n" "$icon" "$code" "$label"
  done

  echo ""
  echo "───────────────────────────────────────────────────────"
  echo "  ✓ OK:        $OK"
  echo "  ⚠ Warning:   $WARN"
  echo "  ✗ Fail:      $FAIL"
  echo "  🚨 Ético:    $ETHICAL_FAIL"
  echo "───────────────────────────────────────────────────────"

  if [ $ETHICAL_FAIL -gt 0 ]; then
    echo ""
    echo "🚨 VEREDITO: BLOQUEADO POR VIOLAÇÃO ÉTICA"
    echo "   Não entregar ao cliente. Corrigir os itens marcados como [ÉTICO]."
    exit 2
  elif [ $FAIL -gt 0 ]; then
    echo ""
    echo "⚠ VEREDITO: NÃO ESTÁ PRONTO"
    echo "   $FAIL critérios não passaram. Revisar antes de apresentar."
    exit 1
  elif [ "$MODE" = "--strict" ] && [ $WARN -gt 0 ]; then
    echo ""
    echo "⚠ VEREDITO: WARNINGS EM MODO STRICT"
    exit 1
  else
    echo ""
    echo "✅ VEREDITO: PRONTO PRA APRESENTAR"
    [ $WARN -gt 0 ] && echo "   ($WARN warnings menores · não bloqueiam)"
  fi
fi
