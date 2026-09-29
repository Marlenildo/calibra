ui <- fluidPage(
  tags$head(
    tags$script(async = NA, src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-3130340973057636", crossorigin = "anonymous"),
    tags$link(rel = "stylesheet", type = "text/css", href = "css/app.css"),
    tags$meta(name = "author", content = "Marlenildo"),
    tags$meta(name = "description", content = "Calibra: insira os pontos da curva de calibração e veja a reta, a equação e o R²."),
    tags$link(rel = "icon", type = "image/png", href = "img/favicon.png"),
    tags$title("Calibra · Curva de calibração e R²")
  ),

  div(class = "cabecalho-app",
    tags$img(src = "img/logo_app.png", class = "logo-app", alt = "Logo do Calibra"),
    div(class = "titulo-area",
      div(class = "titulo", "Calibra"),
      div(class = "descricao-app", "Curva de calibração e R²"),
      div(class = "subtitulo", "Digite ou cole os pontos lidos no laboratório. A curva e o R² aparecem na hora.")
    )
  ),

  fluidRow(
    class = "grade-trabalho",
    column(4,
      div(class = "painel cartao",
        h4(class = "titulo-cartao", tags$span(class = "numero-passo", 1), "Pontos da curva"),
        div(class = "planilha", rHandsontableOutput("planilha")),
        div(class = "explicacao nota-planilha", "Vírgula decimal aceita · Ctrl+V cola do Excel · botão direito insere ou remove linhas.")
      )
    ),
    column(8,
      div(class = "painel cartao painel-visual",
        h4(class = "titulo-cartao", tags$span(class = "numero-passo", 2), "Curva"),
        uiOutput("resumo"),
        plotOutput("grafico", height = "440px")
      )
    )
  ),

  div(class = "nota-privacidade", icon("lock"), span(TEXTO_PRIVACIDADE)),

  div(class = "rodape-app",
    span("Desenvolvido por"),
    tags$img(src = "img/logo_marlenildo.png", class = "logo-rodape", alt = "Marlenildo Soluções em Curso"),
    span(class = "versao-app",
      tags$a(href = "https://github.com/Marlenildo/calibra/blob/main/CHANGELOG.md", target = "_blank", rel = "noopener",
             title = "Ver novidades desta versão", paste0("Calibra v", VERSAO_APP)))
  )
)
