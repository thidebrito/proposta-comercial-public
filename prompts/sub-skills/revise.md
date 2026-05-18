# Sub-skill · `:revise`

> Re-executa UMA fase específica de um pitch existente · mantém as outras intactas.

## Quando invocar

```
/proposta-comercial:revise <fase> <pasta>
```

Fases válidas:
- `research` — re-roda decupação do cliente
- `strategy` — re-roda oportunidades + produtos (mantém briefing + research)
- `design` — re-roda paleta + tipografia (mantém estratégia)
- `copy` — re-roda copy dos 12 slides (mantém design)
- `build` — re-monta o HTML (mantém tudo)

Casos de uso:
- Cliente discordou da paleta → `:revise design`
- Strategist propôs produto que viola compliance → `:revise strategy`
- Copywriter gerou copy genérica → `:revise copy`
- Quer testar paleta diferente → `:revise design --variant`

## Comportamento

1. Lê `STATE.json` da pasta · valida que fase pedida tem snapshot anterior
2. **Cria snapshot da versão atual** antes de regenerar (rollback possível)
3. Roda apenas o agente daquela fase (researcher/strategist/etc.)
4. Atualiza arquivos da fase
5. Atualiza `STATE.json` com nova revisão no `history`
6. Re-roda **apenas as fases dependentes** (ex: revise strategy → re-roda design+copy+build)

## Cascata de dependências

```
research  → afeta: strategy, design, copy, build
strategy  → afeta: copy, build  (design pode permanecer se quiser)
design    → afeta: copy, build  (copy pode adaptar tom)
copy      → afeta: build
build     → afeta: nada
```

## Output

```
🔄 Revisando fase: {{FASE}}
   📸 Snapshot v{{N-1}} salvo em snapshots/{{FASE}}-{{TIMESTAMP-OLD}}/

✅ {{FASE}} regenerada · v{{N}}
   Cascata: re-rodando {{FASES_DEPENDENTES}}...

   ✓ {{FASE_DEP_1}} atualizada
   ✓ {{FASE_DEP_2}} atualizada
   ✓ Build atualizado

🌐 Browser recarregando: http://localhost:8765/pitch.html
```

## Modo `--variant`

Se passar `--variant`, em vez de SOBRESCREVER a fase, **cria nova variante** lado a lado:

```
/proposta-comercial:revise design --variant
```

Cria `v2` no `STATE.json`, gera `pitch-v2.html` separado, mantém `pitch.html` original.
Use `:variant compare v1 v2` pra ver diff.

## Validação

Antes de regenerar:
- ✓ Pasta tem `STATE.json`
- ✓ Fase anterior está concluída (não pode regenerar `copy` se `design` não rodou)
- ✓ Snapshot anterior existe

Se falha → mostra erro específico e sugere comando correto.
