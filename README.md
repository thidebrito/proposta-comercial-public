# Skill · `proposta-comercial`

> Transforma um briefing curto em uma **proposta comercial visual premium** — pitch HTML interativo de 8 a 15 slides, com identidade visual customizada, projeções financeiras conservadoras, mocks visuais dos produtos propostos e validador automático de ética.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![Version](https://img.shields.io/badge/version-2.1-blue.svg)

---

## ✨ O que essa skill faz

Você responde 8 a 30 perguntas estratégicas, e a skill entrega um pitch profissional pronto pra:

- 📺 Apresentar ao vivo no browser
- 📄 Exportar como PDF
- 🔗 Publicar como link privado (Vercel/Netlify)

**Padrão de qualidade:** equivalente ao que agências cobram R$5-15k pra fazer manualmente.

---

## 📊 3 níveis de briefing — escolha o seu

| Nível | Perguntas | Tempo | Slides | Quando usar |
|---|---|---|---|---|
| 🟢 **Express** | 8 | ~5 min | 8 core | Cliente conhecido, prazo apertado |
| 🟡 **Standard** | 18 | ~15 min | 12 canônicos | Cliente novo, ticket médio/alto · **DEFAULT** |
| 🔴 **Premium** | 30 | ~40 min | 15 (+ Quem propõe + Cases + FAQ) | Cliente top-tier, JV estratégica |

---

## 🚀 Como instalar

### Pré-requisitos
- **Claude Code** instalado (`claude` no terminal)
- **Python 3** (`python3 --version` retorna 3.x)
- **WebFetch** habilitado no Claude Code

### Instalação

```bash
# 1. Descompactar este pacote
unzip proposta-comercial.zip

# 2. Copiar pra pasta de skills do Claude Code
cp -R proposta-comercial-distrib ~/.claude/skills/proposta-comercial

# 3. Dar permissão de execução aos scripts
chmod +x ~/.claude/skills/proposta-comercial/scripts/*.sh

# 4. Validar
ls ~/.claude/skills/proposta-comercial/
```

Você deve ver: `SKILL.md`, `BRIEFING.md`, `agents/`, `library/`, `scripts/`, `templates/`, `prompts/`, `examples/`.

---

## 🎬 Como usar

### Invocação básica

```bash
/proposta-comercial
```

A skill vai:

1. **Perguntar o nível** (Express / Standard / Premium)
2. **Fazer as perguntas** do nível escolhido em sequência
3. **Pesquisar o cliente** automaticamente via WebFetch (researcher)
4. **Propor oportunidades + produtos** viáveis pro nicho (strategist)
5. **Definir paleta + tipografia** baseada no cliente (designer)
6. **Escrever o copy** dos slides (copywriter)
7. **Montar o HTML** final (builder)
8. **Validar** 36 critérios + 6 bloqueadores éticos (validator)
9. **Entregar** pasta completa + abrir no browser

### Atalhos

```bash
/proposta-comercial --level=express          # 8 perguntas
/proposta-comercial --level=standard         # 18 perguntas · DEFAULT
/proposta-comercial --level=premium          # 30 perguntas
/proposta-comercial https://cliente.com.br --level=premium    # URL pré-fornecida
/proposta-comercial @briefing.md             # briefing já preenchido em arquivo
```

### Sub-skills modulares

```bash
/proposta-comercial:briefing             # SÓ captura briefing
/proposta-comercial:revise design        # regenera só design
/proposta-comercial:revise copy          # regenera só copy
/proposta-comercial:validate             # roda validador
/proposta-comercial:variant new design   # cria V2 com paleta diferente
```

---

## 📦 O que está incluído

```
proposta-comercial/
├── README.md              ← este arquivo
├── HANDOFF.md             ← documentação técnica completa
├── index.html             ← documentação visual interativa
├── SKILL.md               ← arquivo principal da skill
├── BRIEFING.md            ← 3 níveis · 8/18/30 perguntas estratégicas
├── METODOLOGIA.md         ← framework dos 12 slides · por que cada um existe
├── COMO_USAR.md           ← tutorial passo a passo
├── CHECKLIST_QUALIDADE.md ← critérios de validação
├── COMO_COMPARTILHAR.md   ← como empacotar e distribuir
├── QUALITY_GATES.md       ← os gates humanos por nível
├── CHANGELOG.md           ← histórico de versões
├── LICENSE                ← MIT
├── agents/                ← 5 subagentes especializados
│   ├── researcher.md
│   ├── strategist.md
│   ├── designer.md
│   ├── copywriter.md
│   └── builder.md
├── library/               ← assets pré-prontos
│   ├── color-palettes.json    (10+ paletas por nicho)
│   ├── typography-pairs.json  (6+ pares testados)
│   ├── product-archetypes.json
│   ├── tone-presets.json
│   └── mock-snippets.html
├── scripts/               ← CLI helpers
│   ├── state.sh           (init/phase/complete/approve/snapshot/status)
│   └── validate.sh        (36 critérios + 6 éticos)
├── templates/             ← templates de output
│   ├── pitch.html.template
│   ├── style-tokens.css
│   ├── README.md.template
│   ├── briefing-preenchido.md.template
│   ├── analise-privada.md.template
│   └── STATE.json.template
├── prompts/               ← roteiro de briefing
│   ├── briefing-interativo.md
│   └── sub-skills/
└── examples/              ← reservado pros seus casos
```

---

## 🛡️ Validador automático

Antes de entregar a proposta, a skill roda automaticamente:

```bash
~/.claude/skills/proposta-comercial/scripts/validate.sh <pasta-do-projeto>
```

E checa **36 critérios estruturais + 6 bloqueadores éticos**:

### Bloqueadores éticos (bloqueia entrega se disparam)

- ❌ Sem garantia de cura/resultado financeiro
- ❌ Sem antes/depois (médico/estético)
- ❌ Sem superlativos absolutos sem evidência ("melhor", "único")
- ❌ Stats devem ter fonte verificável
- ❌ Quote do slide "Quem é" não pode ser genérica
- ❌ STATE.json sem ethics_blockers ativos

---

## ⚖️ Princípios inegociáveis

1. **Pesquisa profunda antes de propor** — nunca propor genérico
2. **Oportunidades MENSURÁVEIS** — sempre com fonte de ganho concreto
3. **Produtos VIÁVEIS pro nicho** — respeita regulamentação (CFM/OAB/CFP/ANVISA/CVM)
4. **Identidade visual ABSORVIDA** — paleta vem do cliente quando há
5. **Modelo de parceria ÉTICO** — receita médica/legal direta NUNCA entra em split
6. **CTA final CONCRETO** — sempre promessa de 30 dias mensurável

---

## 📚 Documentação completa

- **[HANDOFF.md](HANDOFF.md)** · documentação técnica completa (tutorial passo a passo + FAQ + troubleshooting)
- **[index.html](index.html)** · documentação visual interativa (abre no browser)
- **[SKILL.md](SKILL.md)** · entrada principal da skill
- **[BRIEFING.md](BRIEFING.md)** · os 3 níveis em detalhe
- **[METODOLOGIA.md](METODOLOGIA.md)** · framework dos 12 slides
- **[COMO_USAR.md](COMO_USAR.md)** · tutorial passo a passo

---

## 🤝 Stack técnico do output

- **HTML/CSS/JS puro** · zero build · zero npm
- **Google Fonts** (variável conforme tipografia escolhida)
- **IntersectionObserver** pra animações (sem libs externas obrigatórias)
- **Servidor local:** `python3 -m http.server 8765`
- **Deploy opcional:** Vercel (`vercel --prod`)

---

## 📜 Licença

MIT — use, modifique e compartilhe livremente.

---

## 🆘 Suporte

Toda documentação está em `HANDOFF.md`. Em caso de dúvida específica:
- Veja **[HANDOFF.md](HANDOFF.md)** seção 17 (Troubleshooting) e 18 (FAQ)
- Abra `index.html` no browser pra documentação visual

---

## 👤 Autor

Feito por **Thiago Brito** ([@thidebrito](https://instagram.com/thidebrito)) · empreendedor digital · 15+ anos de mercado · marketing, tráfego pago e IA aplicada.

- 🌐 [thidebrito.com.br](https://www.thidebrito.com.br)
- 📷 Instagram: [@thidebrito](https://instagram.com/thidebrito)
- 🐙 GitHub: [@thidebrito](https://github.com/thidebrito)

Se essa skill te ajudou, considera:
- ⭐ Dar uma estrela no repositório
- 🐛 Reportar bugs em [Issues](https://github.com/thidebrito/proposta-comercial-public/issues)
- 📢 Compartilhar com outros freelancers e agências

---

## 🛡️ Segurança e privacidade

Antes de compartilhar uma proposta gerada, **revise os arquivos**:

- ✅ `pitch.html` · pode compartilhar com cliente
- ⚠️ `briefing-preenchido.md` · informação coletada, normalmente OK
- 🔒 `analise-privada.md` · **NÃO compartilhar** — contém matriz de pensamento crítico
- 🔒 `STATE.json` · uso interno (snapshots, fases)

Toda proposta gerada pela skill é **confidencial por design** (meta noindex). Não publique URLs em buscadores sem ajustar a meta tag.

Reporte vulnerabilidades via DM no [Instagram @thidebrito](https://instagram.com/thidebrito) ou abrindo issue privada no GitHub.

---

**v2.1 · 2026 · MIT License**
