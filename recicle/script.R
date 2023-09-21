#'

df <- read.csv(file='database.csv', header=TRUE, sep=';',
               stringsAsFactors = TRUE)

head(df)

modelo_tempodist <- lm(formula = mape ~ lookback,data = df)

#Observando os parâmetros do modelo_tempodist
summary(modelo_tempodist)

#Outras maneiras de apresentar os outputs do modelo
#função 'summ' do pacote 'jtools'
summ(modelo_tempodist, confint = T, digits = 4, ci.width = .95)
export_summs(modelo_tempodist, scale = F, digits = 4)

#Visualização do modelo no ambiente Viewer
#função 'extract_eq' do pacote 'equatiomatic'
extract_eq(modelo_tempodist, use_coefs = T) %>%
  kable() %>%
  kable_styling(bootstrap_options = "striped",
                full_width = F,
                font_size = 28)

#Salvando fitted values (variável yhat) e residuals (variável erro) no dataset
tempodist$yhat <- modelo_tempodist$fitted.values
tempodist$erro <- modelo_tempodist$residuals

#Visualizando a base de dados com as variáveis yhat e erro
tempodist %>%
  select(tempo, distancia, yhat, erro) %>%
  kable() %>%
  kable_styling(bootstrap_options = "striped", 
                full_width = F, 
                font_size = 22)

# load package
library(sjPlot)
library(sjmisc)
library(sjlabelled)

m1 <- modelo_tempodist

tab_model(m1, auto.label = FALSE, file='look_back_results.csv')

df%>%filter(mape <= 5)
