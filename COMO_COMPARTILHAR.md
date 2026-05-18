# Como Compartilhar a Skill

> Guia pra quem quer **distribuir** a skill `proposta-comercial` pra outras pessoas (ex: time, comunidade, GitHub).

## Estrutura da skill

A skill é 100% self-contained. Tudo o que precisa pra rodar está dentro de `~/.claude/skills/proposta-comercial/`:

```
proposta-comercial/
├── SKILL.md                    ← entrada · descritor da skill
├── BRIEFING.md                 ← roteiro de perguntas
├── METODOLOGIA.md              ← framework dos 12 slides
├── COMO_USAR.md                ← tutorial passo a passo
├── CHECKLIST_QUALIDADE.md      ← critérios de validação
├── COMO_COMPARTILHAR.md        ← esse arquivo
│
├── templates/                  ← arquivos com placeholders {{}}
│   ├── pitch.html.template     ← coração técnico
│   ├── style-tokens.css        ← variáveis CSS
│   ├── analise-privada.md.template
│   ├── briefing-preenchido.md.template
│   └── README.md.template
│
├── library/                    ← dados estruturados consultados pelos agentes
│   ├── color-palettes.json     ← 12 paletas por nicho
│   ├── typography-pairs.json   ← 6 pares testados
│   ├── product-archetypes.json ← 10 arquétipos por nicho
│   ├── tone-presets.json       ← 7 presets de tom
│   ├── mock-snippets.html      ← 8 mocks visuais
│   └── slide-blocks.html       ← (opcional) blocos plugáveis
│
├── prompts/                    ← prompts standalone
│   └── briefing-interativo.md
│
├── agents/                     ← 5 agentes especializados
│   ├── researcher.md
│   ├── strategist.md
│   ├── designer.md
│   ├── copywriter.md
│   └── builder.md
│
└── examples/                   ← reservado pra exemplos do usuário (vazio)
```

> Esta versão de distribuição não inclui exemplos prontos pra preservar privacidade. Você pode adicionar seus próprios casos em `examples/<seu-caso>/` conforme for usando a skill.

## Modo 1 · Compartilhar manualmente (zip / git)

### Empacotar

```bash
cd ~/.claude/skills/
tar -czf proposta-comercial-v1.0.tar.gz proposta-comercial/
# ou
zip -r proposta-comercial-v1.0.zip proposta-comercial/
```

### Distribuir

Manda o `.tar.gz` ou `.zip` por:
- WhatsApp / e-mail
- Google Drive / Dropbox
- Slack / Discord da comunidade

### Instalação no destino

Pessoa que recebe extrai em `~/.claude/skills/`:

```bash
cd ~/.claude/skills/
tar -xzf proposta-comercial-v1.0.tar.gz
# ou
unzip proposta-comercial-v1.0.zip
```

E roda:

```
/proposta-comercial
```

## Modo 2 · GitHub (recomendado · open source)

### Criar repositório

```bash
cd ~/.claude/skills/proposta-comercial/

# Inicializa git (se não tiver ainda)
git init
git add .
git commit -m "Initial commit · proposta-comercial v1.0"

# Cria repositório no GitHub
gh repo create proposta-comercial --public --source=. --remote=origin
git push -u origin main
```

### README do repo (no GitHub)

Adicionar um README.md específico pro repo (diferente do README.md.template interno):

```markdown
# proposta-comercial

Skill pra Claude Code que cria propostas comerciais HTML interativas premium · 12 slides cinematográficos com identidade visual customizada · sistema de briefing + 5 subagentes especializados.

## Instalação

```bash
git clone https://github.com/SEU-USUARIO/proposta-comercial.git ~/.claude/skills/proposta-comercial
```

## Uso

```
/proposta-comercial
```

## Documentação

- [SKILL.md](./SKILL.md) · entrada principal
- [BRIEFING.md](./BRIEFING.md) · 3 níveis de briefing (8 / 18 / 30 perguntas)
- [METODOLOGIA.md](./METODOLOGIA.md) · framework dos 12 slides
- [COMO_USAR.md](./COMO_USAR.md) · tutorial
- `examples/` · pasta reservada pros seus próprios casos

## Licença

MIT (ou outra que escolher)
```

### Atualizações

Quando atualizar a skill:

```bash
cd ~/.claude/skills/proposta-comercial/
git add .
git commit -m "v1.1 · [mudanças]"
git tag v1.1
git push origin main --tags
```

Pessoas que instalaram via clone podem atualizar:

```bash
cd ~/.claude/skills/proposta-comercial
git pull
```

## Modo 3 · Plugin do Claude Code (futuro)

Quando o Claude Code tiver marketplace de skills, vai dar pra:

```bash
claude plugin install proposta-comercial
```

Não tem ainda em maio/2026, mas a estrutura da skill já está preparada pra isso.

## O que NÃO compartilhar

⚠️ **Cuidado · privacidade:**

- ❌ NÃO compartilha pasta `~/PROJETOS/[cliente]-pitch/` (são pitchs reais com dados privados)
- ❌ NÃO compartilha `analise-privada.md` de clientes reais
- ❌ NÃO compartilha briefings preenchidos com dados reais de clientes
- ❌ NÃO compartilha fotos de clientes baixadas

✅ **OK compartilhar:**

- Todo o conteúdo dentro de `~/.claude/skills/proposta-comercial/` (estrutura, código, templates)
- Documentação (`*.md`)
- Templates (`templates/`)
- Library (`library/`)
- Prompts (`prompts/`)
- Agentes (`agents/`)

## Antes de compartilhar

Faça esse checklist:

- [ ] Removeu qualquer dado real de cliente que sobrou em pastas
- [ ] Atualizou versão no `SKILL.md`
- [ ] Testou a skill rodando em um caso de exemplo
- [ ] Atualizou o `README.md` se for repo público
- [ ] Adicionou `LICENSE` (MIT recomendado pra distribuição livre)

## Como receber feedback

Se for compartilhar via GitHub:

- Issues: usuários reportam bugs / sugestões
- Pull Requests: contribuições aceitas (ex: novas paletas, novos arquétipos)
- Discussions: comunidade compartilha pitchs gerados

## Versionamento

Use **semver** (semantic versioning):

- `v1.0.0` · primeira release pública
- `v1.1.0` · adição de novo arquétipo / paleta / mock
- `v1.0.1` · bugfix sem mudança de API
- `v2.0.0` · mudança breaking (estrutura de placeholders muda)

## Contribuição (se for público)

Adicione no repo um `CONTRIBUTING.md` simples:

```markdown
# Como contribuir

## Adicionar uma paleta nova

1. Edita `library/color-palettes.json`
2. Adiciona paleta com todos os campos obrigatórios
3. Testa com nicho que cabe
4. PR

## Adicionar um arquétipo novo

1. Edita `library/product-archetypes.json`
2. Define 6 produtos viáveis pro nicho
3. Lista regulamentação aplicável
4. PR

## Reportar bug

Issue com:
- Versão da skill
- Comando que rodou
- Output esperado vs obtido
- Briefing usado (anonimizado)
```

## Cuidados éticos ao distribuir

A skill foi desenhada com **filtros éticos** já embutidos:
- Compliance regulatório (CFM, OAB, CFP, etc.) em `product-archetypes.json`
- Lista de palavras proibidas no `copywriter.md`
- Validação automática no `CHECKLIST_QUALIDADE.md`

Antes de distribuir, **NÃO REMOVA esses filtros** — são o que protege quem usar a skill de gerar conteúdo problemático.

## Comunidades sugeridas pra divulgar

- **Comunidade Claude Code Brasil** (Telegram/Discord)
- **r/claude** no Reddit
- **r/marketing** / **r/freelance** (se for relevante)
- **GitHub Trending** (se for público)
- **Hacker News** (se for inovação técnica relevante)

## Roadmap pós-v1.0

Sugestões de evolução pra v1.1+:

- v1.1 · Integração com Notion (importa briefing direto)
- v1.2 · A/B test de paletas (gera 2 versões pro cliente escolher)
- v1.3 · Vídeo intro automático (Higgsfield/HeyGen)
- v2.0 · Análise de objeções com IA (antecipa o que cliente vai dizer)
- v2.1 · Multi-idioma automático (PT-BR + EN + ES + FR)
- v3.0 · Plugin oficial Claude Code marketplace

## Suporte ao usuário final

Se compartilhar amplamente, antecipa essas perguntas:

**Q: Posso usar a skill pra meu cliente real?**
A: Sim, é o uso principal. Skill é grátis pra qualquer uso.

**Q: Os dados que a skill gera são privados?**
A: Sim. Tudo é gerado localmente. Nada sai do seu computador.

**Q: A skill funciona em qualquer Claude Code?**
A: v1.0+. Versões anteriores podem precisar adaptação.

**Q: Posso modificar a skill?**
A: Sim. Licença MIT permite modificação livre.

**Q: Posso revender a skill?**
A: Depende da licença que você escolher. MIT permite uso comercial, mas seria ético creditar a origem.

---

🎉 Pronto pra compartilhar!

Versão 1.0 · Maio/2026 · MIT (sugerido)
