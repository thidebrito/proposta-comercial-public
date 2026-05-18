# Política de Segurança

## Reportar vulnerabilidade

Se você encontrou uma vulnerabilidade de segurança nesta skill, por favor **NÃO abra issue pública**. Em vez disso:

- DM no Instagram: [@thidebrito](https://instagram.com/thidebrito)
- Ou abra uma **security advisory privada** no GitHub: [Security tab → Report a vulnerability](https://github.com/thidebrito/proposta-comercial-public/security/advisories/new)

## O que reportar

- Exposição de dados sensíveis em outputs gerados pela skill
- Bypass dos bloqueadores éticos (E1-E6 do validador)
- Vulnerabilidade em qualquer um dos 5 subagentes (researcher / strategist / designer / copywriter / builder)
- Caminho de injection via briefing (prompt injection)
- Vazamento de dados de clientes anteriores entre sessões

## O que NÃO é vulnerabilidade

- Falsos positivos no validador (use `--bypass-validator=<E#>` se necessário)
- Layout quebrado em browser específico (abra issue normal)
- Sugestões de novas features (use Discussions)

## Privacidade dos seus clientes

Esta skill **NUNCA** envia dados do briefing pra serviços externos exceto quando você roda o `researcher` (que usa WebFetch pra acessar o site público do cliente).

Todos os outputs ficam **localmente** em `~/PROJETOS/<cliente>-pitch/`.

**Você é responsável** por:
- Não compartilhar a pasta `analise-privada.md` (privada por design)
- Não publicar URLs do pitch em buscadores (meta noindex já bloqueia indexação acidental)
- Obter autorização do cliente antes de usar o pitch como exemplo público em portfolio/cases

## Versões suportadas

| Versão | Suporte |
|---|---|
| 2.1.x | ✅ Atual |
| 2.0.x | ⚠️ Apenas bugs críticos |
| < 2.0 | ❌ Sem suporte |

---

**v2.1 · 2026 · MIT License · feito por [@thidebrito](https://instagram.com/thidebrito)**
