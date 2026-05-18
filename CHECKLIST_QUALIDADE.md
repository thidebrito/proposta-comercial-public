# Checklist de Qualidade — 30 Critérios de Validação

> Antes de considerar um pitch "pronto pra apresentar", todos esses 30 itens precisam estar verdes. A skill executa essa validação automaticamente, mas é bom você conhecer os critérios.

---

## 🟢 Bloco A · Briefing (5 critérios)

- [ ] **A1.** Bloco 1 do briefing 100% preenchido (sem buracos)
- [ ] **A2.** Bloco 2 tem pelo menos 1 URL ou perfil oficial do cliente
- [ ] **A3.** Bloco 3 tem ofertas + ticket + volume aproximado
- [ ] **A4.** Bloco 5 deixa explícita a regulamentação do nicho (CFM/OAB/etc.)
- [ ] **A5.** Bloco 6 tem motivação + modelo de parceria escolhido

---

## 🟢 Bloco B · Pesquisa (5 critérios)

- [ ] **B1.** Researcher decupou o site do cliente (não inventou conteúdo)
- [ ] **B2.** Stats no slide 02 são reais e verificáveis
- [ ] **B3.** Quote do slide 03 é REAL (de avaliação real, com fonte e data)
- [ ] **B4.** Fotos são do cliente (baixadas do site/perfil dele)
- [ ] **B5.** Marquee de credenciais (slide 02 final) lista instituições reais

---

## 🟢 Bloco C · Estratégia (5 critérios)

- [ ] **C1.** As 6 oportunidades têm 3 colunas: o quê / por quê é real / ganho mensurável
- [ ] **C2.** Cada oportunidade tem dado de mercado citado (não vaga)
- [ ] **C3.** Os 6 produtos respeitam regulamentação do nicho
- [ ] **C4.** Pelo menos 1 produto B2C principal + 1 produto recorrente B2B
- [ ] **C5.** Nenhum produto over-ambicioso (SaaS R$1M+ no ano 1, etc.)

---

## 🟢 Bloco D · Visual (5 critérios)

- [ ] **D1.** Paleta de 4 cores definida em `style-tokens.css`
- [ ] **D2.** Tipografia (display + body + mono) carrega via Google Fonts
- [ ] **D3.** Mocks visuais coerentes com produtos (se app → iPhone, se ebook → livro)
- [ ] **D4.** Foto do cliente (se houver) está no slide 01 OU 03
- [ ] **D5.** Identidade visual coerente nos 12 slides (não muda do meio pra frente)

---

## 🟢 Bloco E · Copy (5 critérios)

- [ ] **E1.** Tom de voz coerente com nicho (médico ≠ místico ≠ tech)
- [ ] **E2.** Headlines em serif italic, body em sans
- [ ] **E3.** Sem promessas de garantia / resultado fixo
- [ ] **E4.** CTA final tem promessa concreta de 30 dias
- [ ] **E5.** Disclaimer ético na projeção financeira (slide 09)

---

## 🟢 Bloco F · Técnico (5 critérios)

- [ ] **F1.** Servidor local roda sem erro (`python3 -m http.server 8765`)
- [ ] **F2.** Todos os assets/imagens carregam (200 OK em todas rotas)
- [ ] **F3.** Mobile-responsive (testar em DevTools iPhone 14 Pro)
- [ ] **F4.** Modo apresentação (atalhos + fullscreen) funciona
- [ ] **F5.** Sem console.errors no DevTools

---

## ⚖️ Bloco ÉTICO (CRÍTICO — falhar 1 desses bloqueia entrega)

- [ ] **🔴 ÉTICO-1.** Stats inventados? **NÃO** (só usar reais)
- [ ] **🔴 ÉTICO-2.** Quote inventada de cliente/paciente? **NÃO**
- [ ] **🔴 ÉTICO-3.** Promessa de cura/resultado em nicho médico? **NÃO**
- [ ] **🔴 ÉTICO-4.** Antes/depois (médico/estético)? **NÃO**
- [ ] **🔴 ÉTICO-5.** Garantia financeira em nicho regulado pela CVM/Anbima? **NÃO**
- [ ] **🔴 ÉTICO-6.** Split sobre receita médica/legal/clínica primária? **NÃO**

---

## 🎯 Score final

- **30 OK:** ⭐ Pitch pronto · pode apresentar
- **25-29 OK:** Falta polish — revisar itens que falharam
- **20-24 OK:** Voltar uma fase (briefing ou estratégia)
- **<20 OK:** Refazer do zero · briefing superficial

> 🔴 **Falhar QUALQUER item do bloco ÉTICO bloqueia a entrega.** A skill se recusa a entregar pitch com violação ética.

---

## Como rodar a validação

```bash
# Validação automática (futuro · script bash)
~/.claude/skills/proposta-comercial/scripts/validate.sh ~/PROJETOS/[cliente]-pitch/

# Validação manual (agora)
Abrir cada arquivo, conferir cada item da lista
```

---

## Validação manual rápida (15 minutos)

Pra quem quer validar manualmente sem script:

### 1. Abre `briefing-preenchido.md`
- ✅ Todos blocos preenchidos?
- ✅ Stats têm fonte?
- ✅ Restrições do nicho explícitas?

### 2. Abre `analise-privada.md`
- ✅ Oportunidades têm dados de mercado?
- ✅ Produtos respeitam regulamentação?
- ✅ Projeção é conservadora (não otimista)?

### 3. Roda `python3 -m http.server 8765` na pasta
- ✅ Curl em todas rotas retorna 200?
- ✅ Imagens carregam?

### 4. Abre `http://localhost:8765/pitch.html` no Chrome
- ✅ Scroll completo sem jank
- ✅ Counters animam de 0 até valor final
- ✅ Barras do slide 09 animam quando entram em view
- ✅ Sidebar (pontinhos) marca slide ativo

### 5. Aperta F12 (DevTools)
- ✅ Console sem errors
- ✅ Network: todos arquivos 200
- ✅ Mobile view (iPhone 14 Pro): tudo legível

### 6. Aperta `▶ Apresentar`
- ✅ Fullscreen ativa
- ✅ Setas navegam slides
- ✅ ESC sai do fullscreen

### 7. Aperta `Salvar PDF`
- ✅ Diálogo de print abre
- ✅ Preview mostra cada slide como página separada
- ✅ Cores se preservam no PDF

Se passou em todos esses, pode apresentar pro cliente.

---

## Erros que automaticamente bloqueiam entrega

A skill **se recusa a entregar** pitch quando:

1. ❌ Briefing não está preenchido (faltam blocos críticos)
2. ❌ Researcher não conseguiu acessar site do cliente
3. ❌ Quote do slide 03 não pôde ser verificada
4. ❌ Item do bloco ÉTICO falhou
5. ❌ Servidor local retorna erro em qualquer arquivo
6. ❌ Console mostra erros de JavaScript

Nesses casos, skill mostra mensagem específica e instrução pra corrigir.

---

## Como melhorar o pitch DEPOIS da entrega

Se o cliente apontar algo na reunião que não está bom, você pode:

```
/proposta-comercial --revise "cliente quer ver paleta diferente, mais escura"
```

A skill regera só o que você pediu, mantendo o resto.

---

## Critérios bonus (não obrigatórios mas elevam a qualidade)

- 🌟 **B+** Tem citação de mídia onde cliente aparece (jornal, podcast, etc.)
- 🌟 **B+** Tem benchmark específico citado (não genérico)
- 🌟 **B+** Tem aviso de Doctoralia/Trustpilot integrado se aplicável
- 🌟 **B+** Loading otimizado (Lighthouse > 90)
- 🌟 **B+** Versão PT-BR + EN se cliente atende internacional
- 🌟 **B+** Tem call-to-action diferenciado (não só WhatsApp — Cal.com integrado)
