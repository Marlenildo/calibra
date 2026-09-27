server <- function(input, output, session) {

  output$planilha <- renderRHandsontable({
    rhandsontable(dados_iniciais(), rowHeaders = TRUE, stretchH = "all", minSpareRows = 3) |>
      hot_cols(halign = "htRight") |>
      hot_context_menu(allowRowEdit = TRUE, allowColEdit = FALSE)
  })

  dados <- reactive({
    editada <- input$planilha
    if (is.null(editada)) return(dados_iniciais())
    tabela <- tryCatch(hot_to_r(editada), error = function(e) NULL)
    if (is.null(tabela) || ncol(tabela) < 2) dados_iniciais() else tabela
  }) |> debounce(300)

  ajuste <- reactive(ajustar(dados()))

  output$resumo <- renderUI({
    a <- ajuste()
    if (is.null(a)) return(NULL)
    div(class = "grade-indicadores",
      div(class = "indicador indicador-r2",
        div(class = "indicador-rotulo", "R²"),
        div(class = "indicador-valor", num_pt(a$r2, 4))),
      div(class = "indicador",
        div(class = "indicador-rotulo", "Equação"),
        div(class = "indicador-valor", texto_equacao(a)))
    )
  })

  output$grafico <- renderPlot({
    a <- ajuste()
    validate(need(!is.null(a), "Informe pelo menos 2 pontos com concentrações diferentes."))
    grafico_curva(a)
  }, res = 96)
}
