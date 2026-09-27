# Funções e dependências compartilhadas pela aplicação

library(shiny)
library(ggplot2)
library(rhandsontable)

# Versão lida do DESCRIPTION (fonte única; atualize lá e no CHANGELOG.md).
VERSAO_APP <- tryCatch(unname(read.dcf("DESCRIPTION", fields = "Version")[1, 1]), error = function(e) "dev")

TEXTO_PRIVACIDADE <- paste(
  "Os dados ficam apenas na sessão aberta do navegador e são usados somente para desenhar a curva.",
  "Nada é gravado em banco de dados, arquivos ou cookies; ao fechar ou atualizar a página, as informações são descartadas."
)

COLUNAS <- c("Concentração", "Leitura")

# Pontos iniciais (os mesmos do app original)
dados_iniciais <- function() {
  data.frame("Concentração" = c("0", "1", "2", "3", "4"), Leitura = c("1", "2", "3,5", "4,7", "6,5"),
             check.names = FALSE, stringsAsFactors = FALSE)
}

# Aceita vírgula ou ponto decimal ("0,125", "0.125", "1.250,5").
converter_numero <- function(x) {
  texto <- gsub("\\s+", "", as.character(x))
  texto[is.na(texto) | texto == ""] <- NA_character_
  com_virgula <- !is.na(texto) & grepl(",", texto, fixed = TRUE)
  texto[com_virgula] <- sub(",", ".", gsub(".", "", texto[com_virgula], fixed = TRUE), fixed = TRUE)
  suppressWarnings(as.numeric(texto))
}

num_pt <- function(x, digitos) {
  texto <- formatC(x, format = "f", digits = digitos, decimal.mark = ",")
  sub("^-(0(,0+)?)$", "\\1", texto)
}

# Ajuste linear simples: y = a + bx
ajustar <- function(planilha) {
  x <- converter_numero(planilha[[1]])
  y <- converter_numero(planilha[[2]])
  pontos <- data.frame(x = x, y = y)[!is.na(x) & !is.na(y), ]
  if (nrow(pontos) < 2 || length(unique(pontos$x)) < 2) return(NULL)
  fit <- lm(y ~ x, data = pontos)
  list(pontos = pontos, a = unname(coef(fit)[1]), b = unname(coef(fit)[2]), r2 = summary(fit)$r.squared)
}

texto_equacao <- function(ajuste) {
  sinal <- if (ajuste$a < 0) "−" else "+"
  paste0("y = ", num_pt(ajuste$b, 4), "x ", sinal, " ", num_pt(abs(ajuste$a), 4))
}

grafico_curva <- function(ajuste) {
  ggplot(ajuste$pontos, aes(x = x, y = y)) +
    geom_abline(intercept = ajuste$a, slope = ajuste$b, colour = "#2A5C92", linewidth = 1.1) +
    geom_point(size = 3.6, colour = "#173B5B") +
    labs(x = "Concentração", y = "Leitura") +
    theme_minimal(base_size = 15) +
    theme(
      axis.title = element_text(face = "bold", colour = "#173B5B"),
      axis.text = element_text(colour = "#4A6075"),
      panel.grid.major = element_line(linewidth = 0.4, colour = "#E6EDF3"),
      panel.grid.minor = element_blank(),
      axis.line = element_line(colour = "#9DB0C2", linewidth = 0.5),
      plot.margin = margin(12, 16, 10, 10)
    )
}
