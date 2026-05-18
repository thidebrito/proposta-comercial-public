# Sub-skill · `:briefing`

> Roda APENAS o briefing interativo (Camada 1) · sem despachar agentes seguintes.

## Quando invocar

`/proposta-comercial:briefing`

Casos de uso:
- User quer **só capturar dados** sem comprometer com o pipeline completo
- User quer **revisar/refazer** o briefing de um pitch existente
- User quer **testar o roteiro** de perguntas

## Comportamento

1. Pergunta `Qual a pasta do projeto?` (default: criar nova em `~/PROJETOS/[slug]-pitch/`)
2. Roda `state.sh init` se for projeto novo
3. Pergunta nível (express / standard / premium) e executa briefing conforme `prompts/briefing-interativo.md`
4. Salva `briefing-preenchido.md` na pasta
5. Marca fase `briefing` como `completed` no STATE.json
6. **PARA AÍ** · não chama researcher

## Output

```
✅ Briefing salvo em ~/PROJETOS/[slug]-pitch/briefing-preenchido.md
   Fase 1 (briefing) marcada como completed.

Próximos comandos:
  /proposta-comercial:research   ← decupa o cliente
  /proposta-comercial             ← roda pipeline completo a partir daqui
```

## Validação automática

Antes de finalizar, valida que briefing tem (conforme nível escolhido):
- Express (8): nome + nicho + URL + ofertas + diferenciais + regulamentação + modelo + estética
- Standard (18): tudo do Express + posicionamento + provas sociais + tom + motivação + idioma + restrições do dizer
- Premium (30): tudo do Standard + identidade visual + avaliações + canais + investimento + bônus

Se algum essencial falta → volta e pergunta.
