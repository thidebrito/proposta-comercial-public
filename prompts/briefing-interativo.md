# Prompt · Briefing Interativo

> Esse é o roteiro que a skill executa quando o user invoca `/proposta-comercial`. Ele faz as perguntas em sequência, valida respostas, e prepara o terreno pra os agentes.

## Comportamento esperado

A skill deve agir como um **entrevistador inteligente**:
- Faz uma pergunta de cada vez (não sobrecarrega)
- Reconhece quando user já respondeu algo (não repete)
- Pula blocos que dá pra resolver via pesquisa automática (researcher)
- Resume cada bloco antes de avançar
- Valida que campos críticos foram preenchidos

## Estrutura do diálogo

### Abertura

```
Boa! Vamos criar uma proposta comercial premium pro seu cliente.

Antes de começar, qual nível de briefing você quer fazer?

🟢 EXPRESS    · 8 perguntas  · ~5 min  · 8 slides core (ideal pra cliente conhecido)
🟡 STANDARD   · 18 perguntas · ~15 min · 12 slides canônicos (DEFAULT recomendado)
🔴 PREMIUM    · 30 perguntas · ~40 min · 15 slides + Quem propõe + Cases + FAQ

Qual escolhe? (express / standard / premium)
```

[ESPERAR RESPOSTA]

```
Perfeito! Nível [X] selecionado. Vou fazer [N] perguntas em sequência.
Pode pular respostas dizendo "não sei" — eu pesquiso depois via researcher.

📌 Pergunta 1 · Quem é o cliente
```

### Bloco 1 · Quem é o cliente

```
1. Nome / nome profissional do cliente?
   (ex: "Dra. Ana Carolina" / "Estúdio Aurora")

[ESPERAR RESPOSTA]

2. Em uma frase, qual o nicho/especialidade dele(a)?
   (ex: "Cirurgião plástico facial em Brasília")

[ESPERAR RESPOSTA]

3. Cidade · país · ou online?

[ESPERAR RESPOSTA]

4. Anos de mercado?

[ESPERAR RESPOSTA]

5. Como ele(a) próprio(a) se descreve hoje?
   💡 Dica: copia da bio do Instagram ou da home do site dele

[ESPERAR RESPOSTA]
```

✅ **Resumo Bloco 1:** [mostra resumo das 5 respostas]

### Bloco 2 · Presença digital

```
📌 Bloco 2/7 · Presença digital

6. URL do site oficial? (ou "não tem")

[ESPERAR RESPOSTA]

→ SE TEM URL: já vou começar a pesquisa em background.

7. Instagram? (@username)

[ESPERAR RESPOSTA]

8. Outras redes relevantes? (LinkedIn / YouTube / TikTok)

[ESPERAR RESPOSTA]

9. Plataforma de avaliação pública? (Doctoralia / Google / etc.)

[ESPERAR RESPOSTA]

10. Já saiu em alguma mídia? (jornal / podcast / TV)

[ESPERAR RESPOSTA]
```

### Bloco 3 · Operação atual

```
📌 Bloco 3/7 · Operação atual

11. 3 principais ofertas/produtos/serviços?
    Exemplo: "1) Cirurgia facial · 2) Toxina botulínica · 3) Curso online"

[ESPERAR RESPOSTA]

12. Ticket médio (faixa) por categoria?

[ESPERAR RESPOSTA]

13. Volume mensal aproximado?

[ESPERAR RESPOSTA]

14. Canais atuais de captação?
    (Doctoralia / Indicação / Instagram / Google Ads / etc.)

[ESPERAR RESPOSTA]
```

### Bloco 4 · Diferenciais reais

```
📌 Bloco 4/7 · Diferenciais reais

15. 3 diferenciais que ninguém mais tem (ou tem mal)?

[ESPERAR RESPOSTA]

16. Formação acadêmica relevante?
    (universidades, residências, fellowships, certificações)

[ESPERAR RESPOSTA]

17. Provas sociais quantificadas?
    (ex: "+800 cirurgias · 4,9/5 em 200 reviews")

[ESPERAR RESPOSTA]

18. Tem fotos profissionais disponíveis?
    [ ] Sim, kit completo
    [ ] Só headshot
    [ ] Não tem ainda

[ESPERAR RESPOSTA]
```

### Bloco 5 · Restrições do nicho

```
📌 Bloco 5/7 · Restrições éticas (CRÍTICO)

19. Tem regulamentação que restringe publicidade?
    Opções comuns:
    - CFM (médicos) → Resolução 2.336/2023 + 2.314/2022
    - OAB (advogados) → Provimento 205/2021
    - CFA (administradores)
    - CFP (psicólogos) → Resolução 023/2022
    - ANVISA (estética não-médica)
    - Anbima/CVM (financeiro)
    - Sem regulamentação específica

[ESPERAR RESPOSTA]

20. O que ele NÃO pode prometer/dizer no nicho?
    (ex: "não posso garantir cura, mostrar antes/depois")

[ESPERAR RESPOSTA]

21. Tom de voz preferido? Escolha 1:
    🩺 Médico-institucional
    🌿 Místico-feminino
    💼 Executivo-corporativo
    🚀 Tech-moderno
    🎨 Editorial-criativo
    💪 Performance-direto
    📚 Acadêmico-gentil
    ✨ Outro: [descrever]

[ESPERAR RESPOSTA]
```

### Bloco 6 · Meta da proposta

```
📌 Bloco 6/7 · Meta da proposta

22. Por que você quer fechar essa parceria?
    (motivação real · 2-3 frases)

[ESPERAR RESPOSTA]

23. O que VOCÊ traz pra mesa?
    (suas habilidades · ex: "marketing digital, IA, web/dev")

[ESPERAR RESPOSTA]

24. Modelo de parceria preferido?
    A — Service + Royalty (paga setup + % por 24m)
    B — Joint Venture · 60/40 (recomendado · sem desembolso)
    C — Equity · Empresa nova

[ESPERAR RESPOSTA]

25. Investimento que pretende fazer (tempo + recurso)?

[ESPERAR RESPOSTA]
```

### Bloco 7 · Direção visual

```
📌 Bloco 7/7 · Direção visual

26. ID visual existente?
    [ ] Sim, e quero usar a mesma → researcher extrai
    [ ] Sim, mas quero evoluir → designer propõe baseado na atual
    [ ] Não tem → designer cria do zero

[ESPERAR RESPOSTA]

27. Cores que ele(a) gosta? (se já sabe)

[ESPERAR RESPOSTA]

28. Estética geral?
    [ ] Clean institucional
    [ ] Editorial premium
    [ ] Místico-quente
    [ ] Tech-moderno
    [ ] Performance-direto
    [ ] Acadêmico-gentil

[ESPERAR RESPOSTA]

29. Idioma do pitch?
    🇧🇷 PT-BR (padrão)
    🇵🇹 PT-PT
    🇺🇸 EN
    Outro

[ESPERAR RESPOSTA]
```

## Resumo final · validação

```
✅ Briefing completo!

Resumo do que coletei:

[mostra resumo de todas as perguntas respondidas (8/18/30 conforme nível) em formato compacto]

Próximos passos:
1. ⏳ Researcher decupa o cliente em background (~3 min)
2. ⏳ Strategist propõe oportunidades + produtos
3. 👀 Você revisa antes de seguir pra paleta
4. 👀 Você aprova paleta antes de gerar copy final
5. 🚀 Builder monta o HTML

Posso seguir? (S/N)
```

## Comportamentos especiais

### Quando user diz "não sei" / "não tenho"

Skill aceita lacunas. Marca o campo como `[?]` e continua. Ao final, pergunta se quer rodar **researcher** pra preencher automaticamente.

### Quando user pede pra "abreviar"

Skill ativa modo `--express` e reduz pra 8 perguntas core (Blocos 1, 5, 6, 7 obrigatórios; outros opcionais).

### Quando user fornece briefing pré-pronto

```
/proposta-comercial @meu-briefing.md
```

Skill lê o arquivo, valida que tem todos os campos, e pula direto pro researcher.

### Quando user fornece URL no início

```
/proposta-comercial https://cliente.com.br
```

Skill rod researcher PRIMEIRO (em paralelo com o briefing), depois usa os dados pra preencher Blocos 1-2 automaticamente — só pergunta o que faltar.

## Validação automática antes de avançar

Após o briefing, skill executa:

```
✓ Bloco 1 100% preenchido?
✓ Bloco 2 tem pelo menos 1 URL ou perfil?
✓ Bloco 3 tem ofertas + tickets?
✓ Bloco 5 explicita regulamentação?
✓ Bloco 6 tem motivação + modelo de parceria?
✓ Bloco 7 tem decisão visual?
```

Se algum falhar → volta e pede preencher antes de seguir pro researcher.

## Output esperado

O briefing completo é gravado em `briefing-preenchido.md` (usando o template em `templates/briefing-preenchido.md.template`).

Esse arquivo é input dos próximos agentes (researcher → strategist → designer → copywriter → builder).
