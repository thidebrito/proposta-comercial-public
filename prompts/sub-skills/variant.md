# Sub-skill · `:variant`

> Cria, compara e gerencia VARIANTES de um pitch (paleta B vs A, copy alternativo, etc.)

## Quando invocar

```
/proposta-comercial:variant new <pasta>          # cria variante v2 baseado em v1
/proposta-comercial:variant new <pasta> design   # variante só com paleta diferente
/proposta-comercial:variant new <pasta> copy     # variante só com tom diferente
/proposta-comercial:variant list <pasta>         # lista todas variantes
/proposta-comercial:variant compare <pasta> v1 v2 # mostra diff lado a lado
/proposta-comercial:variant promote <pasta> v2   # promove v2 → versão principal
/proposta-comercial:variant delete <pasta> v2    # remove variante
```

## Casos de uso reais

### Caso 1: Cliente pede paleta diferente
```
/proposta-comercial:variant new ~/PROJETOS/cliente-pitch design
```
- Cria v2 com nova paleta (designer agente roda de novo)
- Mantém estratégia e copy idênticos
- Output: `pitch-v2.html` lado a lado de `pitch.html`

### Caso 2: A/B test de tom de voz
```
/proposta-comercial:variant new ~/PROJETOS/cliente-pitch copy
```
- Cria v2 com tom diferente (executive em vez de mystic)
- Mantém produtos, paleta, projeção iguais
- Cliente pode escolher

### Caso 3: Comparar duas versões
```
/proposta-comercial:variant compare ~/PROJETOS/cliente-pitch v1 v2
```
Mostra diff lado a lado:
```
SLIDE 03 · BIO

v1 (atual):
  "Você não é mais um cirurgião — é um cirurgião robótico..."

v2 (variante):
  "Cirurgião robótico certificado · 5,0 estrelas · referência..."
```

### Caso 4: Promover variante vencedora
```
/proposta-comercial:variant promote ~/PROJETOS/cliente-pitch v2
```
- v2 vira `pitch.html` principal
- v1 vira `pitch-v1.html` (mantido como backup)
- STATE.json atualizado (active: "v2")

## Estrutura no STATE.json

```json
{
  "variants": [
    {
      "id": "v1",
      "label": "Original",
      "design_palette": "medical-andros",
      "copy_tone": "medical-institutional",
      "active": false,
      "created_at": "2026-05-08T15:00Z"
    },
    {
      "id": "v2",
      "label": "Mais escuro",
      "design_palette": "tech-modern",
      "copy_tone": "medical-institutional",
      "active": true,
      "created_at": "2026-05-08T16:30Z"
    }
  ]
}
```

## Comportamento detalhado

### `:variant new <pasta> [aspecto]`

Aspectos possíveis: `design`, `copy`, `strategy` ou (sem aspecto = duplica tudo)

1. Lê STATE.json → identifica próximo ID (v2, v3, ...)
2. Copia arquivos da fase relevante pra novos nomes (ex: `style-tokens-v2.css`)
3. Pergunta ao user qual aspecto mudar
4. Roda agente correspondente com nova decisão
5. Gera HTML separado: `pitch-v2.html`
6. Atualiza STATE.json

### `:variant list <pasta>`

```
🎨 Variantes do pitch · cliente-pitch
─────────────────────────────────────
  v1 (active) · Original
       Paleta: medical-andros · Tom: medical-institutional
       Criado: 2026-05-08 15:00

  v2          · Mais escuro
       Paleta: tech-modern · Tom: medical-institutional
       Criado: 2026-05-08 16:30

  v3          · Tom executivo
       Paleta: medical-andros · Tom: executive-corporate
       Criado: 2026-05-08 17:15
```

### `:variant compare <v1> <v2>`

Mostra diff slide-a-slide. Pra cada slide com diferença, exibe:
- Versão A (esquerda)
- Versão B (direita)
- Mudanças de paleta visualizadas em swatch

### `:variant promote <vN>`

1. Backup do `pitch.html` atual → `pitch-v[atual].html`
2. Renomeia `pitch-vN.html` → `pitch.html`
3. Atualiza STATE.json (active: vN)
4. Re-abre browser

## Limitações

- Máximo 5 variantes por projeto (organização)
- Variant de `briefing` não faz sentido (não criar)
- Variant de `research` raramente útil (dados são dados)

## Output

```
✅ Variante v2 criada · cliente-pitch
   Mudança: paleta de medical-andros → tech-modern

   Arquivos criados:
   - style-tokens-v2.css
   - pitch-v2.html

   Compare: /proposta-comercial:variant compare ~/PROJETOS/cliente-pitch v1 v2
   Promover: /proposta-comercial:variant promote ~/PROJETOS/cliente-pitch v2

🌐 Browser: http://localhost:8765/pitch-v2.html
```
