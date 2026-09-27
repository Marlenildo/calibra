# Gera a logo do Calibra (www/img/logo_app.png e www/img/favicon.png).
# Desenho plano, no mesmo traço do Ranova, do Croma e do Minhas Entregas: eixos
# em L, a reta de calibração e quatro padrões (cores CIELCH) alinhados sobre ela.
# Uso: Rscript scripts/gerar_logo_app.R

library(colorspace)

PADROES_X <- c(-.42, -.08, .26, .6)
MATIZES <- c(250, 205, 148, 78)

desenhar_logo <- function(escala = 1) {
  par(mar = c(0, 0, 0, 0), bg = "transparent")
  plot.new(); plot.window(c(-1, 1), c(-1, 1), asp = 1)

  espessura <- 92 * escala
  traco <- espessura * .38
  reta <- function(x) -.62 + (x + .7) * 1.02

  # Eixos em L
  lines(c(-.86, -.86, .86), c(.86, -.86, -.86), col = "#173B5B", lwd = traco, lend = "round", ljoin = "round")

  # Reta de calibração
  segments(-.66, reta(-.66), .78, reta(.78), col = "#173B5B", lwd = traco, lend = "round")

  # Padrões sobre a reta
  for (i in seq_along(PADROES_X)) {
    cor <- hex(polarLAB(L = if (MATIZES[i] > 200) 56 else 64,
                        C = if (MATIZES[i] > 200) 36 else 44, H = MATIZES[i]), fixup = TRUE)
    points(PADROES_X[i], reta(PADROES_X[i]), pch = 16, col = cor, cex = 14 * escala)
  }
}

tipo <- if (capabilities("aqua")) "quartz" else "cairo"
dir.create("www/img", showWarnings = FALSE, recursive = TRUE)
png("www/img/logo_app.png", width = 512, height = 512, bg = "transparent", type = tipo)
desenhar_logo(); dev.off()
png("www/img/favicon.png", width = 64, height = 64, bg = "transparent", type = tipo)
desenhar_logo(escala = 64 / 512); dev.off()
