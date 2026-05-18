# Como Usar — Tutorial Passo a Passo

> Do briefing à entrega final em 30-90 minutos

## Pré-requisitos

- Claude Code rodando localmente
- Skill `proposta-comercial` instalada em `~/.claude/skills/proposta-comercial/`
- Python 3 disponível (pra servidor local: `python3 -m http.server 8765`)
- Acesso a `WebFetch` (pra pesquisar o cliente)

---

## Modo 1 · Uso simples (interativo)

```
/proposta-comercial
```

A skill **pergunta primeiro qual nível** (Express / Standard / Premium), faz só as perguntas do nível escolhido, decupa o cliente, propõe oportunidades + produtos, e gera o pitch. Você responde perguntas e aprova nos pontos-chave.

### Fluxo completo (Standard · default)

```
✓ Skill pergunta: "Qual nível de briefing?"
  → você escolhe: Express (8) / Standard (18) / Premium (30)
  ↓
✓ Briefing interativo (perguntas do nível escolhido)
  ↓
[ researcher decupa o cliente ] ← em background, ~2-3 min
  ↓
✓ Strategist propõe oportunidades + produtos
  → Quality Gate 1: você revisa e aprova/ajusta (1-2 iterações)
  ↓
✓ Designer extrai/define paleta + tipografia
  → Quality Gate 2 (Standard e Premium): você aprova
  ↓
[ copywriter gera copy dos slides ] ← background, ~5 min
  ↓
[ builder monta HTML, testa servidor ] ← background, ~3 min
  ↓
✓ Quality Gate final (todos os níveis): você aprova entrega
  ↓
✅ Pitch entregue + abre no browser
```

### Tempo total esperado
- Briefing: ~10 min (suas respostas)
- Pesquisa + estratégia: ~10 min (tempo de processamento)
- Aprovações: ~5 min (suas decisões)
- Construção: ~10 min (background)
- **Total: 30-45 min**

---

## Modo 2 · Com URL do cliente

```
/proposta-comercial https://cliente.com.br
```

Pula algumas perguntas do briefing porque o researcher já decupa o site primeiro. Útil quando você conhece bem o cliente.

---

## Modo 3 · Com briefing pré-preenchido

Se você já tem todas as respostas, salva num arquivo e usa:

```
/proposta-comercial @meu-briefing.md
```

O arquivo deve seguir o template em [`templates/briefing-preenchido.md.template`](./templates/briefing-preenchido.md.template).

---

## Modo 4 · Express (8 perguntas)

```
/proposta-comercial --express
```

Versão rápida com 8 perguntas core (em vez de 25). Bom pra MVP do pitch — depois você pode pedir aprofundar.

---

## Estrutura do output entregue

```
~/PROJETOS/[nome-cliente]-pitch/
├── pitch.html                   ← Apresentação principal (12 slides)
├── style-tokens.css             ← Variáveis CSS (paleta + fontes)
├── analise-privada.md           ← MATRIZ DE PENSAMENTO (não compartilhar)
├── briefing-preenchido.md       ← Captura do briefing (histórico)
├── README.md                    ← Como rodar local + atalhos
├── _ANALISE.md                  ← Visão estratégica complementar
└── assets/
    ├── cliente-foto-1.jpg       ← Fotos baixadas
    ├── cliente-logo.png
    └── screenshots/             ← Screenshots do site original
```

> 🔒 **Crítico:** `analise-privada.md` é SEU. Não compartilhe com o cliente. É a "carta nas mangas" — análise crítica honesta dos pontos cegos dele, das suas estratégias, das objeções que ele provavelmente vai levantar.

---

## Como rodar o pitch local (depois de gerado)

```bash
cd ~/PROJETOS/[nome-cliente]-pitch
python3 -m http.server 8765
```

Abre http://localhost:8765/pitch.html no Chrome.

### Atalhos do pitch

| Tecla | Ação |
|---|---|
| `↓` `→` `Space` | Próximo slide |
| `↑` `←` | Slide anterior |
| `Home` | Voltar ao topo |
| `End` | Ir pro final |
| `Esc` | Sair do fullscreen |

### Modo apresentação

Botão `▶ Apresentar` no canto superior direito ativa fullscreen. Combine com setas pra navegar slide a slide na reunião com o cliente.

### Salvar PDF

Botão `Salvar PDF` no topo abre o diálogo de impressão. CSS já tem `@media print` ajustado.

---

## Como deployar (compartilhar via link)

> ⚠️ **Atenção:** o pitch é confidencial — NUNCA publica em domínio público sem `noindex`.

### Opção A · Vercel (recomendado)

```bash
cd ~/PROJETOS/[nome-cliente]-pitch
vercel --prod
```

Vai gerar URL tipo `cliente-pitch-abc123.vercel.app`. Já tem `<meta name="robots" content="noindex,nofollow">` no HTML.

### Opção B · Netlify

```bash
netlify deploy --prod
```

### Opção C · GitHub Pages (não recomendado pra material confidencial)

---

## Iterando depois de gerar

Se quiser ajustar algo (paleta, copy, produtos), edite os arquivos diretamente:

- **Mudar paleta:** edita `style-tokens.css` (variáveis no `:root`)
- **Mudar copy:** edita `pitch.html` (conteúdo entre tags)
- **Trocar foto:** substitui em `assets/`
- **Adicionar produto:** copia bloco do `<article class="product-card">` e duplica
- **Mudar projeção:** edita tabela e barras na seção `.proj`

Skill também suporta re-execução parcial:

```
/proposta-comercial --update copy   → regera só o copy
/proposta-comercial --update design → regera só a paleta
/proposta-comercial --update produtos → regera só o slide 08
```

---

## Erros comuns e troubleshooting

### "Pitch ficou genérico"
**Causa:** briefing superficial / researcher não rodou.
**Solução:** rode `/proposta-comercial --re-research` pra rodar o researcher de novo com mais profundidade.

### "Paleta não bateu com a marca do cliente"
**Causa:** site do cliente está datado e researcher pegou cores erradas, OU cliente não tem ID visual.
**Solução:** edita manualmente em `style-tokens.css` ou roda `/proposta-comercial --update design` informando paleta nova.

### "Cliente tem regulamentação X que não está respeitada"
**Causa:** Bloco 5 do briefing foi superficial.
**Solução:** edita `analise-privada.md` adicionando restrições, depois roda `/proposta-comercial --update produtos`.

### "Slide 08 ficou com produtos não-viáveis"
**Causa:** strategist propôs sem checar `library/product-archetypes.json`.
**Solução:** rode `/proposta-comercial --update produtos` confirmando o nicho do cliente.

### "Servidor local dá erro de CORS no iframe"
**Causa:** abriu o `pitch.html` direto (file://) em vez de servir via http.
**Solução:** sempre use `python3 -m http.server 8765` e abra `http://localhost:8765`.

### "Imagens não carregam"
**Causa:** caminho errado no HTML após mover pasta.
**Solução:** todas as imagens devem ser relativas (`assets/foto.jpg`, não absolute).

### "Lighthouse score baixo"
**Causa:** imagens não otimizadas.
**Solução:** rode `/proposta-comercial --optimize` pra comprimir todas em WebP.

---

## Checklist antes de apresentar pra cliente

Antes de mostrar pra ele, valide:

- [ ] Abrir no Chrome em laptop · scroll completo sem jank
- [ ] Abrir no iPhone · todas seções legíveis
- [ ] Apertar `▶ Apresentar` · fullscreen funciona
- [ ] Setas navegam entre slides com smooth scroll
- [ ] "Salvar PDF" gera arquivo legível
- [ ] Slide 07 com iframe carrega corretamente
- [ ] Slide 09 com barras animadas no scroll
- [ ] Stats no slide 02 contam de 0 ao valor final
- [ ] Botões de WhatsApp abrem com mensagem correta
- [ ] Nome do cliente está correto em TODOS os slides (não esquece um lugar)
- [ ] Cores do `style-tokens.css` batem com identidade visual proposta
- [ ] Lighthouse > 85 em Performance e > 95 em Accessibility

---

## Como o cliente vai consumir

Cenários típicos pós-reunião:

### Cenário 1 · Cliente quer reler em casa
Mande o link Vercel privado. Ele scrolla no próprio ritmo, vê os mocks, lê com calma.

### Cenário 2 · Cliente quer compartilhar com sócio/cônjuge
Mesmo link Vercel privado funciona. Ou exporta PDF e manda por WhatsApp.

### Cenário 3 · Cliente quer apresentar pro contador
Recomenda que ele exporte PDF (a parte da projeção financeira é o que importa).

### Cenário 4 · Cliente diz "vou pensar"
Mande recap em texto curto + link do pitch + reforço do CTA dos 30 dias. Se ele não responder em 5 dias, follow-up amigável.

---

## Próximos passos depois do "sim"

Quando o cliente aceitar a parceria, a skill **termina seu papel**. Próximos passos (fora do escopo):

1. **Contrato de parceria** — use modelo separado, advogado revisa
2. **Setup técnico** — repo + Vercel + Supabase + Stripe (skill diferente)
3. **Primeiro produto ao vivo** — fase de execução real

A `proposta-comercial` foi o ponto de partida. O resto é trabalho de implementação.

---

## Dicas pra deixar o pitch ainda mais forte

### Antes da reunião
- Roda Lighthouse e ajeita Performance até > 90
- Comprima imagens grandes (mestres / fotos pessoais)
- Teste em Safari também (alguns clientes usam)

### Durante a reunião
- Comece pela CAPA (não pula slides 01-03 — eles aquecem o cliente)
- Use os atalhos de teclado (deixa fluido, não fica clicando)
- Pause no slide 05 (oportunidades) — esse é o slide pra discutir com o cliente
- Termine sempre no slide 12 com a CTA dos 30 dias

### Depois da reunião
- Mande o link em até 1h pós-reunião (enquanto está fresco)
- Inclua texto curto recapitulando 3 pontos-chave
- Reforce o CTA dos 30 dias: "Pronto pra começar?"

---

## Como o pitch evolui com o tempo

A skill `proposta-comercial` v1.0 entrega o pitch base. Próximas versões podem ter:

- v1.1: integração com Notion (importa briefing direto)
- v1.2: A/B test de paletas (gera 2 versões pro cliente escolher)
- v1.3: vídeo intro automático (Higgsfield/HeyGen)
- v2.0: análise de objeções com IA (antecipa o que cliente vai dizer)

Sugestões? Abra issue no repo (link em `COMO_COMPARTILHAR.md`).
