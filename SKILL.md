---
name: proposta-comercial
description: Cria propostas comerciais HTML interativas premium para qualquer cliente — pitch cinematográfico com scroll editorial, identidade visual customizada e mocks visuais dos produtos propostos. Sistema com 3 níveis de briefing (Express 8 perguntas / Standard 18 / Premium 30) + 5 subagentes especializados (researcher, strategist, designer, copywriter, builder) + Quality Gates humanos + validador automático. Use quando precisar criar pitch profissional pra fechar parceria com cliente, agência, freelancer ou empresa em qualquer nicho.
---

# Skill — Proposta Comercial · Pitch HTML Interativo

> Versão 2.1 · Maio/2026 · MIT · Compartilhável

## 🆕 Novidades v2.1

- **3 níveis de briefing** · Express (8) · Standard (18) · Premium (30) — usuário escolhe antes de começar
- **Entregas diferenciadas por nível** · Express = 8 slides core · Standard = 12 canônicos · Premium = 15 (com Quem propõe + Cases + FAQ)
- **Sistema de estado** (`STATE.json`) · cada projeto rastreia fase, aprovações, snapshots
- **Quality Gates adaptativos** · Express 1 · Standard 2 · Premium 3
- **4 sub-skills** modulares · `:briefing` · `:revise` · `:validate` · `:variant`
- **Validador automático** · 30 critérios + 6 éticos · bloqueia entrega se violar ética
- **Sistema de variantes** · cria v2/v3 pra A/B test sem refazer tudo
- **Snapshots automáticos** · poder voltar atrás em qualquer fase

## 📊 3 Níveis de Briefing — escolha o seu

| Nível | Perguntas | Tempo | Slides | Quando usar |
|---|---|---|---|---|
| 🟢 **Express** | 8 | ~5 min | 8 core | Cliente conhecido, prazo apertado |
| 🟡 **Standard** | 18 | ~15 min | 12 canônicos | Cliente novo, ticket médio/alto · **DEFAULT** |
| 🔴 **Premium** | 30 | ~40 min | 15 (com Quem propõe + Cases + FAQ) | Cliente top-tier, JV estratégica |

Detalhes completos em `BRIEFING.md`.

Skill que transforma um briefing simples em uma **proposta comercial visual de 12 slides**, padrão premium, no formato de site interativo (HTML+CSS+JS puro, sem build), pronta pra apresentar ao vivo, exportar PDF ou publicar como link privado.

## Quando usar

- Você é freelancer/agência/consultor e precisa fechar parceria com novo cliente
- Você quer apresentar evolução de marca/site/produto pra um cliente atual
- Você quer testar uma ideia de joint venture com expert/criador
- Você é vendedor B2B e precisa de pitch personalizado por conta

## Quando **não** usar

- Pitch pra fundo de investimento (use deck financeiro tradicional)
- Apresentação técnica/científica (use slides estáticos)
- Documento legal/contratual (use Word/Google Docs)

## O que ela entrega

```
saida/
├── pitch.html              ← apresentação principal · 12 slides scroll editorial
├── style-tokens.css        ← variáveis CSS (paleta + tipografia customizada)
├── analise-privada.md      ← matriz de pensamento (não compartilhar com cliente)
├── briefing-preenchido.md  ← captura do briefing pra histórico
├── README.md               ← como rodar local + deploy
└── assets/                 ← fotos, logos, screenshots do cliente
```

## Como funciona (visão geral)

```
0. Skill pergunta: "Qual nível de briefing?" (Express / Standard / Premium)
1. Briefing interativo (8 / 18 / 30 perguntas conforme nível)
2. Researcher (subagente)                  → decupa site/perfil do cliente
3. Strategist (subagente)                  → propõe oportunidades + produtos
   ↑ Quality Gate (Standard e Premium)
4. Designer (subagente)                    → extrai/define paleta + tipografia
   ↑ Quality Gate (apenas Premium)
5. Copywriter (subagente)                  → gera copy dos slides
6. Builder (subagente)                     → monta HTML, testa servidor local
   ↑ Quality Gate final (todos os níveis)
7. Entrega: abre no browser + entrega pasta completa
```

## Os 12 slides

| # | Slide | Função |
|---|---|---|
| 01 | **Capa** | Identidade do cliente · posicionamento |
| 02 | **Espelho** | Devolver o que o cliente já tem (8 stats animados) |
| 03 | **Quem é** | Bio editorial com quote real |
| 04 | **O que preservar** | 5 pontos fortes em cards |
| 05 | **Oportunidades** | Tabela com 6 ganhos mensuráveis |
| 06 | **Direção criativa** | Paleta + tipografia + 3 princípios |
| 07 | **Mockup/site** | Iframe com site atual ou mockup novo |
| 08 | **Os 6 produtos** | Cards com mocks visuais e receita estimada |
| 09 | **Projeção** | Tabela + barras animadas |
| 10 | **Modelos de parceria** | 3 cards (A·Service, B·JV recomendado, C·Equity) |
| 11 | **Roadmap** | Timeline horizontal de 6 marcos |
| 12 | **CTA final** | Promessa concreta de 30 dias |

## Como invocar

### Pipeline completo (default)

```bash
/proposta-comercial                          # briefing interativo
/proposta-comercial https://cliente.com.br   # com URL pré-fornecida
/proposta-comercial @briefing.md             # com briefing pré-preenchido
```

### Níveis de briefing

```bash
/proposta-comercial --level=express          # 8 perguntas · 5 min · 8 slides core · 1 QG
/proposta-comercial --level=standard         # 18 perguntas · 15 min · 12 slides · 2 QG · DEFAULT
/proposta-comercial --level=premium          # 30 perguntas · 40 min · 15 slides · 3 QG
```

Sem `--level`, a skill **pergunta interativamente** qual nível usar.

### Sub-skills modulares (v2.1)

```bash
/proposta-comercial:briefing             # só captura briefing
/proposta-comercial:revise design        # regenera só design
/proposta-comercial:revise copy          # regenera só copy
/proposta-comercial:validate             # roda validador
/proposta-comercial:variant new design   # cria v2 com paleta diferente
/proposta-comercial:variant compare v1 v2 # diff entre variantes
/proposta-comercial:variant promote v2   # promove v2 a principal
```

### Scripts diretos (CLI)

```bash
~/.claude/skills/proposta-comercial/scripts/state.sh status <pasta>
~/.claude/skills/proposta-comercial/scripts/validate.sh <pasta>
~/.claude/skills/proposta-comercial/scripts/validate.sh <pasta> --json
```

## Princípios fundamentais

### 1. Pesquisa profunda antes de propor
Nunca propor oportunidades genéricas. SEMPRE decupar o cliente, entender o nicho, mapear restrições reais (CFM, OAB, compliance), antes de sugerir produtos.

### 2. Oportunidades MENSURÁVEIS
Cada oportunidade tem 3 colunas: **o que evoluir** · **por que é real** · **onde está o ganho mensurável**. Sem vagueza tipo "melhorar SEO". Tem que ser "+30 a 50% leads aproveitados" ou "+R$144k/ano com 30 cons/mês × R$400".

### 3. Produtos VIÁVEIS pro nicho
Médico não pode prometer cura. Advogado não pode dar garantia. Coach financeiro não pode garantir retorno. A skill consulta `library/product-archetypes.json` pra propor produtos coerentes com o nicho.

### 4. Identidade visual ABSORVIDA
Se cliente tem site, paleta vem dele. Se não tem, designer escolhe paleta do nicho em `library/color-palettes.json`. Tipografia segue o tom (médico → Fraunces, místico → Cormorant, tech → Geist).

### 5. Modelo de parceria ÉTICO
Sempre 3 opções (Service / Joint Venture / Equity). JV recomendado por padrão, mas user pode mudar. Receita médica/legal/clínica direta NÃO entra em split (apenas produtos digitais novos).

### 6. CTA final CONCRETO
Sempre uma promessa de 30 dias com algo MENSURÁVEL. "Em 30 dias: telemedicina ao vivo + 5 artigos SEO" — não "começamos a parceria".

## Outputs que devem ser sempre verdadeiros

✅ Stats reais (do site/perfil/avaliações do cliente — nunca inventar)
✅ Quote real de cliente/avaliação (se não tem, NÃO usa quote — usa frase forte)
✅ Projeções **conservadoras** com base em benchmarks reais do mercado
✅ Roadmap viável (datas que dá pra entregar)
✅ Modelo de parceria adequado ao porte do cliente

## Outputs proibidos

❌ Stats fictícios ("90% dos clientes voltam" sem base)
❌ Garantias de resultado financeiro
❌ Antes/depois (em nichos médico/estético)
❌ Promessas que ferem regulamentação do nicho
❌ Quotes inventadas de pacientes/clientes

## Documentação completa

| Arquivo | Conteúdo |
|---|---|
| [BRIEFING.md](./BRIEFING.md) | 3 níveis de briefing · 8 / 18 / 30 perguntas estratégicas |
| [METODOLOGIA.md](./METODOLOGIA.md) | Framework dos 12 slides · por que cada um existe |
| [COMO_USAR.md](./COMO_USAR.md) | Tutorial passo a passo |
| [CHECKLIST_QUALIDADE.md](./CHECKLIST_QUALIDADE.md) | 10 critérios de validação antes de entregar |
| [COMO_COMPARTILHAR.md](./COMO_COMPARTILHAR.md) | Como você empacota e distribui essa skill |

## Subagentes (em `agents/`)

| Agente | Tool | Quando |
|---|---|---|
| `researcher` | WebFetch · Read · Write | Decupa site/perfil do cliente |
| `strategist` | Read · Write | Mapeia oportunidades e produtos |
| `designer` | Read · Write | Define paleta + tipografia |
| `copywriter` | Read · Write | Escreve copy dos 12 slides |
| `builder` | Read · Write · Bash | Monta HTML final + testa servidor |

## Library (em `library/`)

| Arquivo | Conteúdo |
|---|---|
| `color-palettes.json` | 10+ paletas pré-definidas por nicho |
| `typography-pairs.json` | 6+ pares testados (serif + sans + mono) |
| `product-archetypes.json` | Catálogo de produtos viáveis por nicho |
| `tone-presets.json` | Presets de tom (médico, místico, tech, etc.) |
| `mock-snippets.html` | Biblioteca de mocks (iPhone, livro, dashboard, etc.) |
| `slide-blocks.html` | Blocos HTML reutilizáveis dos 12 slides |

## Exemplo

A pasta `examples/` está reservada pros seus próprios casos. Após gerar sua primeira proposta com a skill, você pode salvar uma cópia limpa lá pra referência futura.

## Stack técnico do output

- HTML/CSS/JS puro · zero build · zero npm
- Google Fonts (variável conforme tipografia escolhida)
- IntersectionObserver pra animações (sem libs)
- Servidor local: `python3 -m http.server 8765`
- Deploy opcional: Vercel (`vercel --prod`)

## Não-objetivos da skill

- Não escreve contratos legais (use advogado pra contrato JV)
- Não cuida de pagamento/Stripe (separado)
- Não publica em produção (entrega arquivos locais)
- Não substitui reunião comercial (é o material de apoio)

## Idiomas suportados

- 🇧🇷 PT-BR (padrão)
- 🇵🇹 PT-PT (com ajuste de glossário)
- 🇺🇸 EN (versão internacional · adicionar `--lang=en`)

## Versão e compatibilidade

- v2.1 · Maio/2026 · 3 níveis de briefing
- v2.0 · Maio/2026 · sub-skills + validador automático
- v1.0 · Maio/2026 · primeira versão
- Testada em: macOS Sonoma+ · Chrome 120+ · Firefox 121+ · Safari 17+
- Mobile-responsive (breakpoints 640 · 768 · 1024 · 1280)
- Print-friendly (Salvar PDF funcional)
