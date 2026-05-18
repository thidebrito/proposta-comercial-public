# Quality Gates · 3 Pontos de Aprovação Humana

> Os 3 momentos onde a skill PARA e pede aprovação humana antes de seguir. Reduz custo de retrabalho · garante que cliente final receba o que aprovou.

---

## QG3 · Aprovação de Estratégia (depois do Strategist)

**Quando:** após o `strategist` mapear oportunidades + produtos + projeção, ANTES do `designer` rodar.

**O que mostrar pro user:**

```
═══════════════════════════════════════════════════════
🚦 QUALITY GATE 3 · ESTRATÉGIA
═══════════════════════════════════════════════════════

📊 6 OPORTUNIDADES IDENTIFICADAS:

#1 — Captura ativa de leads
   Por que: 100% dos botões vão pro WhatsApp manual hoje
   Ganho: +30-50% leads aproveitados

#2 — Blog SEO médico
   ...
[lista as 6]

🎯 6 PRODUTOS PROPOSTOS:

#1 — Telemedicina estruturada (R$144k/ano)
#2 — Hub Saúde do Homem (R$80k/ano indireto)
#3 — Canal YouTube + Reels (R$60k/ano)
#4 — Programa Segunda Opinião (R$120k/ano)
#5 — Funil de Cirurgia Robótica (+R$540-900k indireto)
#6 — UroPro Comunidade B2B (R$178k/ano)

💰 PROJEÇÃO ANO 1 (conservadora):
   Total digital: R$ 582k
   Sua parte (60%): R$ 349k
   + Bônus performance (cirurgias adicionais): negociável

───────────────────────────────────────────────────────
QUER APROVAR? Opções:

(S) Sim, aprovado · seguir pra design
(N) Não · refazer estratégia (pedir mais detalhes)
(E) Editar · indicar quais oportunidades/produtos remover/adicionar
(P) Pausar · deixar pra revisar depois
```

**Comportamento por resposta:**

- **S** → marca QG3 aprovado · roda `state.sh approve <pasta> QG3_strategy <by>` · segue pra QG4
- **N** → roda strategist de novo com instruções refinadas
- **E** → user diz o que mudar · skill ajusta · volta a perguntar S/N
- **P** → salva snapshot · marca pausa no STATE.json · sai

**Validação automática (antes de QG3):**
- Análise pública existe
- 6+ oportunidades têm 3 colunas (o quê / por quê / ganho)
- 6+ produtos respeitam compliance do nicho
- Projeção tem disclaimer
- Receita médica/legal NÃO está em split

Se algum auto-check falha → rejeita ANTES de mostrar pro user · roda strategist de novo.

---

## QG4 · Aprovação de Design (depois do Designer)

**Quando:** após o `designer` definir paleta + tipografia + 3 princípios, ANTES do `copywriter` rodar.

**O que mostrar pro user:**

```
═══════════════════════════════════════════════════════
🚦 QUALITY GATE 4 · DIREÇÃO VISUAL
═══════════════════════════════════════════════════════

🎨 PALETA: medical-andros

   ████ #00517B  Andros Blue (primary)
   ████ #013A5A  Deep Navy (primary-deep)
   ████ #C9A961  Premium Gold (accent)
   ████ #F5F8FA  Clinical White (neutral)

   Justificativa: Azul-marinho transmite confiança médica.
   Dourado eleva ticket sem cair em luxo gritante.

✍️ TIPOGRAFIA: fraunces-inter

   Display: Fraunces Italic (premium-medical)
   Corpo:   Inter (clean técnico)
   Mono:    JetBrains Mono (números/badges)

   Sample do título do slide:
   ┌────────────────────────────────┐
   │ Tecnologia da Vinci nas mãos   │
   │ certas — e com escuta          │
   └────────────────────────────────┘

🎯 3 PRINCÍPIOS:
   1. Confiança serena — tipografia que respira
   2. Tecnologia visível — números, KPIs, ícones discretos
   3. Acolhimento humano — foto, depoimentos, voz direta

───────────────────────────────────────────────────────
QUER APROVAR?

(S) Sim · seguir pra copy
(N) Não · escolher outra paleta · pular pra typography-pairs.json
(C) Customizar · informar paleta diferente (você escolhe hex)
(P) Pausar
```

**Comportamento por resposta:**

- **S** → roda `state.sh approve <pasta> QG4_design <by>` · segue pra copy
- **N** → mostra 2-3 alternativas de paleta do nicho · user escolhe
- **C** → user fornece hex codes · skill valida (contraste WCAG AA mínimo)
- **P** → salva snapshot · pausa

**Validação automática:**
- 4 cores hex válidas
- Contraste WCAG AA: text vs background ≥ 4.5:1
- Google Fonts URL valida

---

## QG7 · Validação Final (depois do Builder)

**Quando:** após o `builder` montar HTML, ANTES de declarar "pitch entregue".

**Comportamento (parte automática):**

Roda `scripts/validate.sh <pasta>`:

- Se **PASS** (todos os 30 + 6 éticos OK) → mostra resultado e libera
- Se **FAIL** (algum critério não-ético falhou) → mostra falhas + sugere corrigir antes de seguir
- Se **ETHICAL_BLOCK** → BLOQUEIA · não entrega ao cliente · roda agentes de novo com correções

**Comportamento (parte humana, opcional):**

Se modo for `full` ou `handson`, depois do auto-validator:

```
═══════════════════════════════════════════════════════
🚦 QUALITY GATE FINAL · ENTREGA AO CLIENTE
═══════════════════════════════════════════════════════

✅ Auto-validação: 36/36 critérios PASS

📋 Pitch pronto:
   - 12 slides scroll editorial
   - Paleta: medical-andros
   - Tipografia: Fraunces + Inter
   - 6 produtos com mocks visuais
   - Projeção: R$ 582k ano 1 (conservador)
   - Roadmap: 12 meses, 6 marcos
   - CTA dos 30 dias: telemedicina + 5 artigos

🌐 Disponível em http://localhost:8765/pitch.html

───────────────────────────────────────────────────────
ÚLTIMA REVISÃO ANTES DE FECHAR?

(S) Sim, está pronto · entregar
(R) Revisar · abrir DevTools, ver mobile, conferir
(F) Fix · regenerar fase específica
(D) Deploy · sobe pra Vercel/Netlify pra mandar link pro cliente
```

---

## Quality Gates por nível de briefing

A partir da v2.1, os quality gates são definidos pelo **nível de briefing escolhido** (não mais por flag `--mode`):

### Nível Express (`--level=express`)
- **1 quality gate:** QG final (validate.sh + aprovação humana)
- Pula QG estratégia e QG design (decisões automáticas baseadas no briefing curto)
- Ideal pra pitchs rápidos com cliente conhecido

### Nível Standard (`--level=standard`) · DEFAULT
- **2 quality gates:** QG estratégia (human) + QG final (validate.sh + human)
- Pula QG design (designer aplica regras do briefing direto)
- Equilibra velocidade e controle — ideal pra maioria dos casos

### Nível Premium (`--level=premium`)
- **3 quality gates:** QG estratégia + QG design + QG final
- Cada fase humanamente revisada antes de avançar
- Ideal pra clientes top-tier onde cada detalhe importa

---

## Como o STATE.json registra

Cada aprovação grava:

```json
{
  "approvals": {
    "QG3_strategy": {
      "approved": true,
      "by": "<user>",
      "at": "2026-05-08T16:30:00Z",
      "auto": false,
      "notes": "produtos OK, ajustar projeção do produto 4 pra R$120k em vez de R$144k"
    }
  }
}
```

`state.sh approve <pasta> QG3_strategy <user> "produtos OK, ajustar..."` faz isso.

---

## Bypass de quality gate (emergência)

```bash
state.sh approve <pasta> QG3_strategy --bypass "cliente já aprovou em call"
```

Marca como aprovado COM razão. Bom pra auditoria depois.

---

## Tempo médio por gate

| Gate | Tempo de espera |
|---|---|
| QG3 (estratégia) | 5-15 min · user lê e decide |
| QG4 (design) | 2-5 min · user vê paleta e aprova |
| QG7 (final) | 1-3 min · só conferência rápida |

**Total bloqueado por gates: ~10-25 min** numa execução completa de 30-45 min.

Sem gates seria 25-30 min · com gates 35-50 min · mas a chance de retrabalho cai 80%.
