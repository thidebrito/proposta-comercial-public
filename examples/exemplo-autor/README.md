# Exemplo · @thidebrito (auto-pitch)

Esse é o **exemplo neutro** que vem com a skill `proposta-comercial` — um pitch completo de auto-análise estratégica do Thiago Brito (@thidebrito) sobre o próprio ecossistema digital.

## Por que auto-pitch?

Pra mostrar que a skill funciona até pra **autoanálise**. Quem usa a skill pra um cliente externo segue exatamente o mesmo processo.

E também porque é **anônimo o suficiente** — não expõe dados de nenhum cliente específico, mas usa stack e estilo reais.

## O que tem

- `briefing-preenchido.md` — captura completa do briefing (nível Premium · 30 perguntas respondidas)
- `analise-privada.md` — matriz de pensamento crítico (privada)
- `pitch.html` — apresentação completa funcional, 12 slides
- `style-tokens.css` — paleta laranja/marrom/dourado refletindo identidade @thidebrito (🍊🤎)
- `README.md` — esse arquivo

## Como rodar

```bash
cd ~/.claude/skills/proposta-comercial/examples/exemplo-autor
python3 -m http.server 8765
# abrir http://localhost:8765/pitch.html
```

## Como esse exemplo te ajuda

1. **Ver de perto** como ficar um pitch real produzido pela skill
2. **Inspecionar** estrutura dos placeholders preenchidos
3. **Copiar** padrões que funcionam pro seu caso

## Os 12 slides do exemplo

| # | Slide | Conteúdo |
|---|---|---|
| 01 | Capa | Thiago Brito · auto-pitch · 15+ anos |
| 02 | Espelho | 8 stats reais (15 anos, 8.7k, 58 posts, etc.) |
| 03 | Quem é | Bio editorial · interseção marketing/IA/identidade |
| 04 | O que preservar | 5 pilares (15 anos, stack próprio, site, banda, audiência) |
| 05 | Oportunidades | 6 oportunidades B2B + recorrência |
| 06 | Direção | Paleta laranja/marrom · Instrument Serif + Inter |
| 07 | Site | thidebrito.com.br como base |
| 08 | 6 produtos | Mentoria · Comunidade · Newsletter · YouTube · Imersão · Curso |
| 09 | Projeção | R$843k ano 1 · split 60/40 · disclaimer |
| 10 | Parceria | A · B (recomendado) · C |
| 11 | Roadmap | 6 marcos do mês 0 ao 12 |
| 12 | CTA | Newsletter + 5 vídeos em 30 dias |

## O que NÃO está nesse exemplo

- Pitch real envolveria reunião com cliente externo (esse é auto-análise)
- Em pitch real, há cliente que aprova ou rejeita oportunidades antes do build
- Em pitch real, designer extrairia paleta DO SITE do cliente externo

## Pra criar um pitch real

```bash
# Pra qualquer cliente
/proposta-comercial

# Com URL de cliente já em mãos
/proposta-comercial https://cliente.com.br
```

A skill vai:
1. Perguntar nível de briefing (Express 8 / Standard 18 / Premium 30 perguntas)
2. Fazer briefing interativo (~5 / ~15 / ~40 min conforme nível)
3. Decupar o cliente real
4. Propor oportunidades + produtos
5. Extrair/definir paleta + tipografia
6. Escrever copy dos slides (8/12/15 conforme nível)
7. Montar HTML final
8. Abrir no browser

## Confidencialidade

Esse exemplo é **público** (vem com a skill). Pitchs reais que você gera são privados — `analise-privada.md` NÃO deve ser compartilhado com cliente.

---

✨ Versão 1.0 · Maio/2026 · Skill `proposta-comercial`
