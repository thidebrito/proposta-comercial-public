# Sub-skill · `:validate`

> Roda o validador automático nos 30+ critérios + 6 éticos.

## Quando invocar

```
/proposta-comercial:validate <pasta>
/proposta-comercial:validate <pasta> --strict     # falha em qualquer warning
/proposta-comercial:validate <pasta> --json       # output em JSON pra integração
/proposta-comercial:validate <pasta> --fix        # tenta corrigir falhas auto-corrigíveis
```

## Comportamento

1. Roda `scripts/validate.sh <pasta>`
2. Mostra resultado dos 36 checks (30 normais + 6 éticos)
3. Se `--fix` → tenta corrigir automaticamente:
   - Adicionar disclaimer faltante
   - Substituir placeholders {{}} restantes
   - Renomear assets com caminhos absolutos pra relativos
   - Adicionar viewport meta se faltar
4. Se `--json` → retorna JSON pra integração com outros sistemas

## Saída padrão

```
═══════════════════════════════════════════════════════
🔍 VALIDAÇÃO · cliente-pitch
═══════════════════════════════════════════════════════

✓ [A1] Briefing existe e completo
✓ [A2] Briefing tem URL/perfil do cliente
...

  ✓ OK:        29
  ⚠ Warning:    2
  ✗ Fail:       0
  🚨 Ético:     0

✅ VEREDITO: PRONTO PRA APRESENTAR
   (2 warnings menores · não bloqueiam)
```

## Códigos de saída

- `0` — pronto pra apresentar (zero falhas críticas)
- `1` — não está pronto (alguns critérios não passaram, mas sem violação ética)
- `2` — **BLOQUEADO** por violação ética (não entregar ao cliente)

## Critérios validados

### Bloco A · Briefing (5)
- A1: Briefing existe e completo
- A2: Tem URL/perfil
- A3: Tem oferta + ticket
- A4: Menciona regulamentação
- A5: Modelo de parceria definido

### Bloco B · Pesquisa (5)
- B1: pesquisa-real.md existe
- B2: Tem fontes citadas (URLs)
- B3: Marca lacunas (warning)
- B4: Assets baixados (warning)
- B5: Paleta extraída

### Bloco C · Estratégia (5)
- C1: analise-publica.md existe
- C2: analise-privada.md existe
- C3: 6+ oportunidades
- C4: 6+ produtos
- C5: Disclaimer na projeção

### Bloco D · Visual (5)
- D1: style-tokens.css existe
- D2: 4+ cores hex
- D3: Sem placeholders {{}}
- D4: Google Fonts URL
- D5: Foto/headshot ou fallback

### Bloco E · Copy (5)
- E1: pitch.html existe
- E2: 12 slides
- E3: Sem placeholders
- E4: CTA com prazo concreto
- E5: Disclaimer ético

### Bloco F · Técnico (5)
- F1: HTML válido
- F2: viewport meta
- F3: noindex
- F4: Caminhos relativos
- F5: IntersectionObserver

### Bloco ÉTICO (6 · CRÍTICOS)
- 🚨 E1: Sem garantia de resultado
- 🚨 E2: Sem antes/depois
- 🚨 E3: Sem superlativos absolutos
- 🚨 E4: Stats têm fonte
- 🚨 E5: Quote não-genérica
- 🚨 E6: STATE.json sem ethics_blockers

## Comportamento se fala em ético

⚠ **CRÍTICO:** Se algum critério ético falha, sub-skill:
1. Marca STATE.json com `ethics_blockers`
2. Retorna exit code 2
3. **Recusa entregar pitch** ao cliente
4. Mostra correção específica pra cada item

## Integração com outras skills

```bash
# Em CI/CD
/proposta-comercial:validate <pasta> --json | jq '.verdict'

# Antes de deploy
/proposta-comercial:validate <pasta> --strict || exit 1

# Em loop
for p in ~/PROJETOS/*-pitch; do
  /proposta-comercial:validate "$p"
done
```
