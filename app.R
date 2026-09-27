# Calibra — Curva de calibração e R². Ponto de entrada da aplicação.
source("global.R", local = TRUE)
source("ui.R", local = TRUE)
source("server.R", local = TRUE)

shinyApp(ui = ui, server = server)
