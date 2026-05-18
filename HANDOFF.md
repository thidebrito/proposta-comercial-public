# HANDOFF · Skill `proposta-comercial`

> **Documento explicando tudo o que essa skill faz, como ela funciona, e como qualquer pessoa pode usá-la pra gerar propostas comerciais visuais premium em HTML.**
>
> Versão da skill: 2.1 · MIT License

---

## Sumário

1. [O que é a skill](#1-o-que-é-a-skill)
2. [Pra quem é](#2-pra-quem-é)
3. [Como instalar e validar](#3-como-instalar-e-validar)
4. [Como invocar — passo a passo](#4-como-invocar--passo-a-passo)
5. [Os 3 níveis de briefing](#5-os-3-níveis-de-briefing)
6. [O que acontece nos bastidores](#6-o-que-acontece-nos-bastidores)
7. [Os 5 subagentes especializados](#7-os-5-subagentes-especializados)
8. [Quality Gates humanos](#8-quality-gates-humanos)
9. [Validador automático](#9-validador-automático)
10. [Outputs entregues](#10-outputs-entregues)
11. [Sub-skills modulares](#11-sub-skills-modulares)
12. [Library de assets](#12-library-de-assets)
13. [Princípios inegociáveis](#13-princípios-inegociáveis)
14. [Outputs proibidos](#14-outputs-proibidos)
15. [Stack técnico](#15-stack-técnico)
16. [Troubleshooting](#16-troubleshooting)
17. [FAQ](#17-faq)
18. [Roadmap](#18-roadmap)
19. [Licença](#19-licença)

---

## 1. O que é a skill

`proposta-comercial` é uma **skill de Claude Code** que transforma um briefing curto em uma **proposta comercial visual premium** — um pitch HTML interativo de 8 a 15 slides, com identidade visual customizada, projeções financeiras conservadoras, mocks visuais dos produtos propostos e validador automático de ética.

**Em uma frase:** você responde 8 a 30 perguntas estratégicas, e a skill entrega um pitch profissional pronto pra apresentar ao cliente, exportar PDF ou publicar como link privado.

**Por que isso importa:** propostas comerciais geralmente são feitas em PowerPoint genérico ou Google Slides apressado. Esta skill produz HTML interativo cinematográfico — mesmo padrão de qualidade que agências cobram R$5-15k pra fazer manualmente.

---

## 2. Pra quem é

### ✅ Use quando você é:

- **Freelancer/consultor** fechando parceria com novo cliente
- **Agência** apresentando evolução de marca/site/produto pra cliente atual
- **Empreendedor** propondo joint venture com expert/criador
- **Vendedor B2B** que precisa de pitch personalizado por conta
- **Solopreneur** querendo padronizar a qualidade de propostas

### ❌ NÃO use pra:

- Pitch pra fundo de investimento (use deck financeiro tradicional)
- Apresentação técnica/científica (use slides estáticos)
- Documento legal/contratual (use Word/Google Docs)
- Pitch de evento ou palestra (formatos diferentes)

---

## 3. Como instalar e validar

### Pré-requisitos

- **Claude Code** instalado e funcionando (`claude` no terminal)
- **Python 3** disponível (`python3 --version` deve retornar 3.x)
- **WebFetch** habilitado no Claude Code (necessário pra researcher)

### Instalação

```bash
# 1. Descompactar o pacote distribuível
unzip proposta-comercial.zip

# 2. Copiar pra pasta de skills do Claude Code
cp -R proposta-comercial-distrib ~/.claude/skills/proposta-comercial

# 3. Dar permissão de execução aos scripts
chmod +x ~/.claude/skills/proposta-comercial/scripts/*.sh

# 4. Validar
ls ~/.claude/skills/proposta-comercial/
```

Você deve ver:

```
SKILL.md          ← arquivo principal
BRIEFING.md       ← perguntas dos 3 níveis
METODOLOGIA.md    ← framework dos slides
COMO_USAR.md      ← tutorial passo a passo
CHECKLIST_QUALIDADE.md
COMO_COMPARTILHAR.md
QUALITY_GATES.md
CHANGELOG.md
agents/           ← 5 subagentes
library/          ← paletas, archetypes, tipografias
scripts/          ← state.sh + validate.sh
templates/        ← templates de output
prompts/          ← roteiro do briefing
examples/         ← reservado pros seus casos
```

Se ver isso, ✅ está pronto pra usar.

---

## 4. Como invocar — passo a passo

### 🎬 Cenário: você abre o terminal e quer criar uma proposta pra um cliente novo

**Passo 1 — você digita no terminal:**

```bash
/proposta-comercial
```

**Passo 2 — a skill responde:**

```
Boa! Vamos criar uma proposta comercial premium pro seu cliente.

Antes de começar, qual nível de briefing você quer fazer?

🟢 EXPRESS    · 8 perguntas  · ~5 min  · 8 slides core (cliente conhecido)
🟡 STANDARD   · 18 perguntas · ~15 min · 12 slides canônicos (DEFAULT)
🔴 PREMIUM    · 30 perguntas · ~40 min · 15 slides + Quem propõe + Cases + FAQ

Qual escolhe? (express / standard / premium)
```

**Passo 3 — você escolhe (ex: "standard"):**

A skill começa a fazer as 18 perguntas, uma de cada vez, esperando sua resposta antes de seguir pra próxima:

```
📌 Pergunta 1/18 · Nome do cliente
   (ex: "Dra. Ana Carolina" / "Estúdio Aurora")

> [você responde aqui]

📌 Pergunta 2/18 · Em uma frase, qual o nicho/especialidade?
   (ex: "Cirurgião plástico facial" / "Coach de carreira pra programadores")

> [você responde aqui]

[... continua até a pergunta 18 ...]
```

**Passo 4 — após responder tudo, a skill mostra resumo:**

```
✅ Briefing completo!

Resumo do que coletei:
- Cliente: [nome]
- Nicho: [nicho]
- Site: [URL]
- Ofertas: [3 ofertas + ticket]
- Diferenciais: [3 itens]
- Modelo de parceria: [A/B/C]
- Estética: [categoria escolhida]

Próximos passos:
1. ⏳ Researcher decupa o cliente em background (~3 min)
2. ⏳ Strategist propõe oportunidades + produtos
3. 👀 Você revisa antes de seguir (Quality Gate 1)
4. 🚀 Builder monta o HTML

Posso seguir? (S/N)
```

**Passo 5 — você aprova, e a skill executa em sequência:**

```
[ researcher decupa o site/redes do cliente ]   ← ~3 min em background
   ↓
[ strategist propõe 6 oportunidades + 6 produtos ]
   ↓
   ✋ Quality Gate 1 · você revisa as oportunidades:
      - Continuar com essas 6?
      - Ajustar alguma?
      - Substituir uma específica?
   ↓
[ designer aplica paleta e tipografia ]
   ↓
[ copywriter gera copy dos 12 slides ]   ← ~5 min em background
   ↓
[ builder monta HTML, testa servidor local ]   ← ~3 min em background
   ↓
   ✋ Quality Gate final · você aprova entrega
   ↓
✅ Pitch entregue!
   📂 ~/PROJETOS/<cliente>-pitch/
   🌐 Aberto no browser: http://localhost:8765/pitch.html
```

### Atalhos para invocar com nível pré-definido

```bash
/proposta-comercial --level=express          # pula direto pro Express
/proposta-comercial --level=standard         # Standard (DEFAULT recomendado)
/proposta-comercial --level=premium          # Premium (máximo)
/proposta-comercial https://cliente.com.br --level=premium    # com URL pré-fornecida
/proposta-comercial @briefing.md             # com briefing já preenchido em arquivo
```

---

## 5. Os 3 níveis de briefing

A skill tem 3 níveis de briefing — você escolhe **antes de começar** com base em quanto tempo quer investir e quanta profundidade o cliente merece.

### 🟢 NÍVEL 1 · Express

| | |
|---|---|
| **Perguntas** | 8 essenciais |
| **Tempo** | ~5 min |
| **Slides entregues** | 8 core |
| **Quality Gates** | 1 (final) |
| **Quando usar** | Cliente conhecido, prazo apertado, validação rápida de fit |

**Perguntas:** Nome · Nicho · URL · Ofertas+ticket · Diferenciais · Regulamentação · Modelo parceria · Estética

**Slides entregues:** Capa · Espelho (números) · Quem é · Oportunidades · Os 6 produtos · Projeção · Modelos de parceria · CTA final

### 🟡 NÍVEL 2 · Standard (DEFAULT recomendado)

| | |
|---|---|
| **Perguntas** | 18 estratégicas |
| **Tempo** | ~15 min |
| **Slides entregues** | 12 canônicos |
| **Quality Gates** | 2 (estratégia + final) |
| **Quando usar** | Cliente novo, ticket médio/alto, primeira proposta |

**Perguntas extras (além do Express):** Anos de mercado · Posicionamento atual · Instagram · Volume mensal · Provas sociais · Restrições do dizer · Tom de voz · Motivação da parceria · O que você traz · Idioma

**Slides extras (além do Express):** O que preservar · Direção criativa · Mockup/site · Roadmap 12 meses

### 🔴 NÍVEL 3 · Premium

| | |
|---|---|
| **Perguntas** | 30 (cobertura máxima) |
| **Tempo** | ~40 min |
| **Slides entregues** | 15 |
| **Quality Gates** | 3 (estratégia + design + final) |
| **Quando usar** | Cliente top-tier, ticket altíssimo (>R$50k), JV estratégica, primeira impressão decisiva |

**Perguntas extras (além do Standard):** Cidade · Outras redes · Mídia anterior · Avaliações públicas · Canais de captação · Tráfego do site · Formação acadêmica · Fotos profissionais · Investimento (tempo+recurso) · Cores que gosta · Identidade visual existente · Bônus contextuais

**Slides extras (além do Standard):** Quem propõe (você) · Cases & Resultados · FAQ + Riscos

### Tabela completa: slides por nível

| Slide | Express | Standard | Premium |
|---|:---:|:---:|:---:|
| 01 · Capa | ✅ | ✅ | ✅ |
| 02 · Espelho (números reais) | ✅ | ✅ | ✅ |
| 03 · Quem é (bio editorial) | ✅ | ✅ | ✅ |
| 04 · O que preservar | — | ✅ | ✅ |
| 05 · Oportunidades | ✅ | ✅ | ✅ |
| 06 · Direção criativa | — | ✅ | ✅ |
| 07 · Mockup/site | — | ✅ | ✅ |
| 08 · Os 6 produtos | ✅ | ✅ | ✅ |
| 09 · Projeção financeira | ✅ | ✅ | ✅ |
| 10 · Modelos de parceria | ✅ | ✅ | ✅ |
| 11 · Roadmap | — | ✅ | ✅ |
| 12 · CTA final | ✅ | ✅ | ✅ |
| ⊕ · Quem propõe (você) | — | — | ✅ |
| ⊕ · Cases & Resultados | — | — | ✅ |
| ⊕ · FAQ + Riscos | — | — | ✅ |

---

## 6. O que acontece nos bastidores

Quando você responde "Posso seguir?" no passo 5 do briefing, a skill orquestra **5 subagentes em sequência**, cada um com responsabilidade clara:

```
Briefing capturado
    ↓
1. Researcher          ← decupa site/redes do cliente (WebFetch)
    ↓
2. Strategist          ← propõe oportunidades + produtos viáveis pro nicho
    ↓ Quality Gate 1 (Standard e Premium)
3. Designer            ← extrai/define paleta + tipografia
    ↓ Quality Gate 2 (apenas Premium)
4. Copywriter          ← escreve copy dos slides
    ↓
5. Builder             ← monta HTML/CSS/JS, testa servidor local
    ↓
6. Validator           ← roda 36 critérios + 6 bloqueadores éticos
    ↓ Quality Gate final (todos os níveis)
✅ Pitch entregue
```

Cada subagente é uma **conversa especializada** — eles têm prompts próprios em `agents/`, e usam apenas as ferramentas necessárias pra sua função (researcher tem WebFetch; designer não).

---

## 7. Os 5 subagentes especializados

### 1. `researcher` (`agents/researcher.md`)
- **Tools:** WebFetch · Read · Write
- **Quando:** depois do briefing, em background
- **Função:** acessa o site/perfis do cliente e extrai dados verificáveis (stats, identidade visual, tom, mídia)
- **Output:** `analise-privada.md` (matriz de pensamento privada que orienta os próximos agentes)

### 2. `strategist` (`agents/strategist.md`)
- **Tools:** Read · Write
- **Quando:** após researcher
- **Função:** mapeia 6 oportunidades concretas (mensuráveis) + 6 produtos viáveis pro nicho do cliente
- **Output:** seção "oportunidades" e "produtos" no `analise-privada.md`
- **Consulta:** `library/product-archetypes.json` pra propor só produtos viáveis no nicho (médico não promete cura, etc)

### 3. `designer` (`agents/designer.md`)
- **Tools:** Read · Write
- **Quando:** após Quality Gate 1 (estratégia aprovada)
- **Função:** extrai paleta do site do cliente OU escolhe do nicho · define tipografia (display + body + mono)
- **Output:** `style-tokens.css` com variáveis CSS prontas
- **Consulta:** `library/color-palettes.json` (10+ paletas) e `library/typography-pairs.json` (6+ pares)

### 4. `copywriter` (`agents/copywriter.md`)
- **Tools:** Read · Write
- **Quando:** após Quality Gate 2 ou após designer
- **Função:** escreve o copy dos slides em tom direto, premium, sem corporativês
- **Output:** copy de cada slide preenchido em `templates/pitch.html.template`

### 5. `builder` (`agents/builder.md`)
- **Tools:** Read · Write · Bash
- **Quando:** última etapa antes do validador
- **Função:** monta o HTML final, copia assets, sobe servidor local pra teste, abre no browser
- **Output:** `pitch.html` funcional + servidor `python3 -m http.server 8765`

---

## 8. Quality Gates humanos

Quality Gates são **pausas obrigatórias** onde a skill espera sua aprovação antes de continuar. O número de gates depende do nível escolhido:

| Nível | Quality Gates | Onde |
|---|---|---|
| Express | 1 | Final (após builder, antes da entrega) |
| Standard | 2 | Após estratégia + Final |
| Premium | 3 | Após estratégia + Após design + Final |

**Por que existem:** evita que a skill entregue algo que você não aprovaria. Cada gate é uma chance de:
- Aprovar e seguir
- Pedir ajuste pontual ("substitui a oportunidade #3 por X")
- Pedir refazer essa fase ("o tom ficou corporativo demais, mais leve")
- Cancelar e desistir

**Cada gate registra um snapshot** em `STATE.json` — se você quiser voltar ao estado anterior, o `state.sh` permite.

---

## 9. Validador automático

Antes de entregar a proposta final, a skill roda automaticamente:

```bash
~/.claude/skills/proposta-comercial/scripts/validate.sh <pasta-do-projeto>
```

E checa **36 critérios estruturais + 6 bloqueadores éticos**:

### Critérios estruturais (36)

**Estrutura (E1-E5):**
- pitch.html existe
- Tem todos os slides do nível escolhido
- Sem placeholders `{{}}` restantes
- CTA final menciona "30 dias" ou prazo concreto
- Disclaimer ético na projeção financeira

**Formato (F1-F5):**
- HTML válido
- Viewport meta presente
- Noindex (documento confidencial)
- Caminhos de assets RELATIVOS (não absolutos)
- JavaScript de animação presente (IntersectionObserver)

### Bloqueadores éticos (6)

Estes **bloqueiam a entrega** se disparam:

- **E1:** Sem garantia de cura/resultado financeiro
- **E2:** Sem antes/depois (proibido em médico/estético)
- **E3:** Sem 'melhor', 'único' (superlativos absolutos sem evidência)
- **E4:** Stats têm fonte verificável (researcher gerou ou briefing forneceu)
- **E5:** Quote do slide "Quem é" não é genérica
- **E6:** STATE.json sem ethics_blockers ativos

### Output do validador

```
✓ OK:        36
⚠ Warning:    0
✗ Fail:       0
🚨 Ético:     0

✅ VEREDITO: PRONTO PRA APRESENTAR
```

Se algum critério falha, a skill **avisa antes de entregar** e oferece corrigir.

---

## 10. Outputs entregues

Toda proposta gera uma pasta com a seguinte estrutura:

```
~/PROJETOS/<slug-do-cliente>-pitch/
├── pitch.html              ← apresentação principal · scroll editorial
├── style-tokens.css        ← variáveis CSS (paleta + tipografia)
├── analise-privada.md      ← matriz de pensamento (NÃO compartilhar com cliente)
├── briefing-preenchido.md  ← captura do briefing (referência histórica)
├── README.md               ← como rodar local + deploy
├── STATE.json              ← estado do projeto (snapshots, fases, aprovações)
└── assets/                 ← fotos do cliente, logos, screenshots
```

### Como apresentar

```bash
cd ~/PROJETOS/<slug>-pitch/
python3 -m http.server 8765
# abrir http://localhost:8765/pitch.html no browser
```

### Como exportar PDF

1. Abre o pitch no Chrome
2. `Cmd+P` → "Salvar como PDF"
3. Layout: paisagem · margens: nenhuma · gráficos de fundo: ativado

### Como gerar versão self-contained (single HTML)

A skill tem helper Python que:
- Inlina o style-tokens.css no `<style>`
- Encoda todas imagens como base64
- Resulta em 1 arquivo HTML único de ~3-5 MB que funciona offline

---

## 11. Sub-skills modulares

Pra iterar rápido sem refazer tudo, use as sub-skills:

```bash
/proposta-comercial:briefing             # SÓ captura briefing
/proposta-comercial:revise design        # regenera só design
/proposta-comercial:revise copy          # regenera só copy
/proposta-comercial:revise strategy      # regenera só estratégia
/proposta-comercial:validate             # roda validador
/proposta-comercial:variant new design   # cria V2 com paleta diferente
/proposta-comercial:variant compare v1 v2  # diff entre variantes
/proposta-comercial:variant promote v2   # V2 vira principal
```

### Casos de uso

- **Cliente disse "muda a cor pra azul":** `:revise design` (não refaz o resto)
- **Quer testar 2 abordagens:** `:variant new design` cria V2 paralela
- **Quer atualizar projeção:** `:revise strategy` regenera só essa parte

---

## 12. Library de assets

A skill vem com biblioteca pré-pronta em `library/`:

| Arquivo | Conteúdo | Como é usado |
|---|---|---|
| `color-palettes.json` | 10+ paletas pré-definidas por nicho | Designer escolhe quando cliente não tem identidade |
| `typography-pairs.json` | 6+ pares testados (display + body + mono) | Designer escolhe baseado no tom |
| `product-archetypes.json` | Produtos viáveis por nicho | Strategist filtra propostas que ferem regulamentação |
| `tone-presets.json` | Presets de tom (médico, místico, tech...) | Copywriter calibra a voz |
| `mock-snippets.html` | Biblioteca de mocks (iPhone, livro, dashboard) | Builder injeta visualizações de produto |

Se você quiser adicionar paleta nova, basta editar `color-palettes.json` no formato existente — a skill aceita.

---

## 13. Princípios inegociáveis

São **as fundações** da skill. Violar bloqueia a entrega no validador.

### 1. Pesquisa profunda antes de propor
Nunca propor oportunidades genéricas. Decupar o cliente, entender o nicho, mapear restrições reais (CFM, OAB, CFP, ANVISA, CVM) antes de sugerir produtos.

### 2. Oportunidades MENSURÁVEIS
Cada oportunidade tem 3 colunas: **o que evoluir** · **por que é real** · **onde está o ganho mensurável**.

❌ "Melhorar SEO" (genérico, vago)
✅ "+30 a 50% leads aproveitados via remarketing" (mensurável)
✅ "+R$144k/ano com 30 cons/mês × R$400" (concreto)

### 3. Produtos VIÁVEIS pro nicho
Médico não pode prometer cura. Advogado não pode dar garantia. Coach financeiro não pode garantir retorno. A skill consulta `library/product-archetypes.json` pra filtrar só produtos coerentes com o nicho.

### 4. Identidade visual ABSORVIDA
Se cliente tem site, paleta vem dele (researcher extrai). Se não tem, designer escolhe paleta do nicho em `library/color-palettes.json`. Tipografia segue o tom (médico → Fraunces, místico → Cormorant, tech → Geist).

### 5. Modelo de parceria ÉTICO
Sempre 3 opções (Service / Joint Venture / Equity). JV recomendado por padrão, mas user pode mudar. **Receita médica/legal/clínica direta NÃO entra em split** (apenas produtos digitais novos).

### 6. CTA final CONCRETO
Sempre uma promessa de 30 dias com algo MENSURÁVEL.

❌ "Começamos a parceria" (vago)
✅ "Em 30 dias: telemedicina ao vivo + 5 artigos SEO" (concreto)

---

## 14. Outputs proibidos

Estes disparam **bloqueio automático** no validador:

❌ Stats fictícios ("90% dos clientes voltam" sem base verificável)
❌ Garantias de resultado financeiro ("você vai faturar X")
❌ Antes/depois (em nichos médico/estético — fere regulamentação)
❌ Promessas que ferem regulamentação do nicho
❌ Quotes inventadas de pacientes/clientes
❌ Superlativos absolutos sem evidência ("o melhor", "o único", "o maior")

---

## 15. Stack técnico

### Output da skill (o pitch gerado)

- **HTML/CSS/JS puro** · zero build · zero npm
- **Google Fonts** (variável conforme tipografia escolhida)
- **IntersectionObserver** pra animações (sem libs externas obrigatórias)
- **Servidor local:** `python3 -m http.server 8765`
- **Deploy opcional:** Vercel (`vercel --prod`)

### Bibliotecas opcionais de encantamento visual

Pra adicionar magia extra ao pitch (cards 3D, scroll cinematográfico, números animando), recomendamos as seguintes libs validadas:

| Lib | Peso | Função |
|---|---|---|
| Anime.js | 17kb | Timelines de animação genéricas |
| Splitting.js | 5kb | Texto quebrado em chars pra animar letra por letra |
| CountUp.js | 3kb | Números animando de 0 → valor (KPIs, stats) |
| vanilla-tilt | 8kb | Cards 3D Apple-style com glare |
| GSAP + ScrollTrigger | 70kb | Parallax, scroll cinematográfico |
| canvas-confetti | 2kb | Burst de confete em CTAs |

Todas opcionais — o pitch funciona perfeitamente só com IntersectionObserver nativo.

---

## 16. Troubleshooting

### "skill não foi encontrada"
Verifique se a pasta `~/.claude/skills/proposta-comercial/` existe. Se não, descompacte o zip e copie pra lá.

### "validate.sh: command not found"
Permissão de execução: `chmod +x ~/.claude/skills/proposta-comercial/scripts/*.sh`

### "Python error inlining CSS"
Garantir que Python 3.7+ está instalado: `python3 --version`. A v2.1 corrigiu o bug do regex de inline.

### "HTML aberto no Chrome mas sem CSS"
1. Abra DevTools (Cmd+Opt+I)
2. Aba Network — recarregue
3. Procure por linhas vermelhas (404)
4. Provavelmente algum arquivo de assets/ tá faltando

### "Researcher não consegue acessar o site"
WebFetch tem rate limits. Aguarde 1 min e refaça com `:revise research`.

### "Validador trava com bloqueador ético"
Algum texto ou stat tá violando os 6 critérios E1-E6. Olhe o output exato do `validate.sh`, ele aponta a linha específica.

---

## 17. FAQ

**P: Posso usar a skill em cliente que NÃO tem site?**
R: Sim. Researcher pula a decupação automática, mas você precisa ter Instagram/LinkedIn pelo menos. Se não tem nada digital, recomendo nível Express (8 perguntas captam tudo).

**P: A skill funciona em outros idiomas?**
R: Sim — PT-BR (default), PT-PT (com ajuste de glossário), EN (versão internacional via `--lang=en`). A pergunta de idioma está no nível Standard e Premium.

**P: Posso editar o HTML depois?**
R: Sim, totalmente. O output é HTML puro, qualquer editor funciona. As variáveis CSS estão centralizadas em `style-tokens.css`.

**P: A skill substitui agência de marketing?**
R: Não. Substitui o **pitch comercial inicial** (que abre a porta). Implementação real ainda precisa do trabalho dela.

**P: Posso ajustar o validador?**
R: Sim — `scripts/validate.sh` é shell script editável. Mas cuidado: os 6 critérios éticos são INEGOCIÁVEIS por design.

**P: Posso usar em cliente que tem regulamentação especial (médico, advogado)?**
R: Pode, e foi pensado pra isso. A skill conhece CFM (Resoluções 2.336/2023, 2.314/2022), OAB (Provimento 205/2021), CFP (Resolução 023/2022), CFA, ANVISA (RDC 786/2023), Anbima/CVM. Pergunta no briefing.

**P: A skill cobra alguma coisa?**
R: Não. MIT License. Custo zero. O que você gasta é só o tempo de Claude API durante a execução (~5-15 min de processamento).

---

## 18. Roadmap

### v2.1 (atual)
- [x] 3 níveis de briefing (Express / Standard / Premium)
- [x] Quality gates adaptativos por nível
- [x] Bug do CSS inline corrigido
- [x] Slides extras no Premium (Quem propõe / Cases / FAQ)

### v2.2 (próximo)
- [ ] Templates de proposta por nicho (médico, advogado, coach financeiro, creator economy)
- [ ] Exportador automático Vercel/Netlify embutido
- [ ] Cal.com integrado no slide CTA
- [ ] QR code pra compartilhar a proposta
- [ ] Mock de vídeo intro (Loom embed) no slide capa
- [ ] Tabela comparativa com alternativas (CMO interno vs JV vs agência)

### v3.0 (visão)
- [ ] Versão multi-idioma com tradução automática
- [ ] Integração com banco de leads (Supabase)
- [ ] Auto-aprovação de design baseada em ML do feedback histórico
- [ ] Variantes A/B com tracking automático

---

## 19. Licença

MIT License — use, modifique e compartilhe livremente.

```
Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

**v2.1 · 2026 · MIT License**
