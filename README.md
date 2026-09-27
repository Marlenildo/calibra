<p align="center"><img src="www/img/logo_app.png" width="120" alt="Logo do Calibra"></p>

# Calibra

<p>
  <a href="https://github.com/Marlenildo/calibra/releases"><img alt="Versão" src="https://img.shields.io/github/v/release/Marlenildo/calibra?label=vers%C3%A3o&color=2a5c92"></a>
  <a href="LICENSE"><img alt="Licença MIT" src="https://img.shields.io/badge/licen%C3%A7a-MIT-4d965d"></a>
  <img alt="R >= 4.1" src="https://img.shields.io/badge/R-%E2%89%A5%204.1-173b5b">
</p>

**Curva de calibração e R²** — digite ou cole os pontos lidos no laboratório e veja na hora a reta, a equação e o R².

Aplicativo [Shiny](https://shiny.posit.co/) para o laboratorista conferir rapidamente se a curva de uma análise tem um bom ajuste.

## Como usar

1. Na planilha, informe a **concentração** e a **leitura** de cada ponto (vírgula decimal aceita; Ctrl+V cola do Excel).
2. A curva, a equação `y = bx + a` e o **R²** aparecem ao lado e se atualizam a cada edição.

Os dados ficam apenas na sessão aberta: nada é gravado em banco de dados, arquivos ou cookies.

## Como executar

Requer R 4.1 ou superior.

```r
install.packages(c("shiny", "ggplot2", "rhandsontable"))
shiny::runApp()
```

Ou direto do GitHub:

```r
shiny::runGitHub("calibra", "Marlenildo")
```

## Estrutura

- `app.R`: ponto de entrada · `ui.R`: interface · `server.R`: lógica · `global.R`: ajuste e gráfico
- `www/`: estilos e imagens · `scripts/gerar_logo_app.R`: gera a logo do app
- `DESCRIPTION`: versão e dependências · `CHANGELOG.md`: histórico · `CITATION.cff`: citação · `LICENSE`: licença MIT

## Licença

MIT © Marlenildo
