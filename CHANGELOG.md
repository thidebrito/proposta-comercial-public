# Changelog

Todas as mudanças relevantes na skill `proposta-comercial`.

Formato baseado em [Keep a Changelog](https://keepachangelog.com).
Versionamento [Semantic Versioning](https://semver.org).

---

## [2.1.0] · 2026-05-08

### ✨ Adicionado

#### 3 níveis de briefing
- `BRIEFING.md` · reescrito com 3 níveis: Express (8 perguntas · 5 min · 8 slides) · Standard (18 · 15 min · 12 slides) · Premium (30 · 40 min · 15 slides)
- Skill pergunta interativamente o nível antes de começar (ou via `--level=`)
- Quality gates adaptativos: 1 (Express) · 2 (Standard) · 3 (Premium)
- Validação automática diferenciada por nível

#### Slides extras no nível Premium
- Quem propõe (você) — após capa
- Cases & Resultados — após preservar
- FAQ + Riscos — antes do CTA

### 🔄 Mudado
- `SKILL.md` · seção "Modos de execução" → "Níveis de briefing"
- `prompts/briefing-interativo.md` · pergunta nível antes de iniciar
- `prompts/sub-skills/briefing.md` · validação por nível
- `QUALITY_GATES.md` · gates definidos pelo nível, não mais por `--mode`
- `COMO_USAR.md` · fluxo descreve escolha de nível
- Pasta `examples/` reservada pra casos do usuário (sem exemplo embarcado nesta distribuição)

### 🗑️ Removido
- Flags `--mode=full / express / handson / autopilot` (substituídas por `--level=express / standard / premium`)
- A semântica antiga de "modos" (handson/autopilot) foi absorvida pelos níveis

### 🐛 Corrigido
- Bug crítico no script de inline-CSS Python: regex agora suporta `<link ... />` (com espaço/barra). Antes silenciosamente falhava em substituir o link externo, fazendo o HTML self-contained perder variáveis CSS quando aberto via `file://`.

---

## [2.0.0] · 2026-05-08

### ✨ Adicionado

#### Sistema de estado e snapshots
- `templates/STATE.json.template` · estado por projeto
- `scripts/state.sh` · CLI pra gerenciar STATE (init/phase/complete/approve/snapshot/status)
- Snapshots automáticos em pontos-chave (rollback possível)
- Histórico completo de eventos pra auditoria

#### 3 Quality Gates de aprovação humana
- `QUALITY_GATES.md` · documento detalhando os 3 gates
- **QG3** · aprovação de estratégia (oportunidades + produtos + projeção)
- **QG4** · aprovação de design (paleta + tipografia)
- **QG7** · validação final (auto + humano)

#### 4 Sub-skills modulares
- `prompts/sub-skills/briefing.md` · só captura briefing
- `prompts/sub-skills/revise.md` · regenera fase específica
- `prompts/sub-skills/validate.md` · valida pitch existente
- `prompts/sub-skills/variant.md` · cria/compara/promove variantes

#### Validador automático
- `scripts/validate.sh` · 30 critérios + 6 éticos
- Códigos de saída: 0=ok, 1=fail, 2=ético-blocked
- Modos: `--strict`, `--json`, `--fix`
- Bloqueio ético inviolável

#### Sistema de variantes
- Cria v2/v3 lado a lado (paleta B, copy alternativo)
- Promote · compare · delete
- A/B test sem refazer pipeline inteiro

#### 4 Modos de execução
- `--mode=full` (default) · 3 quality gates · 30-45 min
- `--mode=express` · 8 perguntas · 1 gate · 15-20 min
- `--mode=handson` · todos gates · 60-90 min
- `--mode=autopilot` · zero gates humanos · 10-15 min

### 🔄 Modificado

- `SKILL.md` · seção de novidades v2.0 + sub-skills + modos de execução
- README de cada componente atualizado pra refletir v2.0

### 📚 Documentação

- `QUALITY_GATES.md` · NOVO · explica os 3 gates em profundidade
- `CHANGELOG.md` · NOVO · este arquivo
- `SKILL.md` · seção de novidades v2.0

### 🛡️ Segurança / Ética

- Bloqueio ético inviolável: pitchs com violação de compliance NÃO são entregues
- 6 critérios éticos no `validate.sh` que retornam exit code 2
- Lista de palavras proibidas por nicho aplicada automaticamente

---

## [1.0.0] · 2026-05-08

### ✨ Lançamento inicial

- Briefing interativo de 7 blocos
- 5 agentes especializados (researcher, strategist, designer, copywriter, builder)
- Template HTML com 12 slides scroll editorial
- Library com 12 paletas, 6 tipografias, 10 arquétipos de produto, 8 mocks visuais
- Pasta `examples/` reservada pra casos próprios do usuário
- Documentação completa (SKILL, BRIEFING, METODOLOGIA, COMO_USAR, CHECKLIST_QUALIDADE, COMO_COMPARTILHAR)

---

## Roadmap futuro

### [2.1.0] · sugestões
- Versionamento de stylesheets em variantes
- Integração com Notion (importa briefing)
- A/B test automático com 2 paletas

### [2.2.0] · sugestões
- Vídeo intro automático (HeyGen/Higgsfield)
- Análise de objeções com IA antes da reunião

### [3.0.0] · big bets
- Plugin oficial Claude Code marketplace
- Multi-idioma automático (PT-BR + EN + ES + FR)
- Análise de A/B test pós-reunião
