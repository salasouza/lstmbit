#'--------------------------------------------------------------
#' Data Analysis for Dataset
#'
#'-------------------------------------------------------------

#' Install Packages

pacotes <- c("plotly","tidyverse","ggrepel","fastDummies","knitr","kableExtra",
             "splines","reshape2","PerformanceAnalytics","correlation","see",
             "ggraph","psych","nortest","rgl","car","ggside","tidyquant","olsrr",
             "jtools","ggstance","magick","cowplot","emojifont","beepr","Rcpp",
             "equatiomatic")

options(rgl.debug = TRUE)

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

#' Enter of datasets
#" Result of experiment of Hyperparametrization in wandb

wandb_ex <- read.csv(file='df_resumed.csv',
               header=TRUE,
               sep=',',
               stringsAsFactors = TRUE)


setwd("D:/Projects/RNNcrypto/dados_tcc/tcc_mba")
save.image('mba.RData')
load('mba.RData')

saveRDS(wandb_ex, file='wandb_ex.RData')

list.files()

df = readRDS("wandb_ex.RData"); head(df)

#'


df%>%head(3)

df <- df[,-1]
df%>%head(3)

summary(df)

hist(df$mape)

df

#' Model natural 
#' 

model <- aov(formula = mape ~ volume + lookback + volume:lookback,
                       data = df)

summary(model)
anova(model)

par(mfrow=c(2,2))
plot(model)

hist(model$residuals, 
     main='Histograma do resíduos',
     xlab='Resíduos do modelo',
     ylab='Frequência')
hist(model$fitted.values,
     main='Histograma do resíduos',
     xlab='Resíduos do modelo',
     ylab='Frequência')
boxplot(mape ~ volume, data=df,
        main='Boxplot do efeito do volume de dados',
        xlab='Volume',
        ylab='MAPE')
boxplot(mape ~lookback, data=df, 
        main='Boxplot do efeito do lookback',
        xlab='Lookback',
        ylab='MAPE')

# #Para calcular o lambda de Box-Cox
# #função 'powerTransform' do pacote 'car'
# lambda_BC <- powerTransform(df$mape)
# lambda_BC
# 
# #Inserindo o lambda de Box-Cox na base de dados para a estimação de um novo modelo
# df$bcmape <- (((df$mape ^ lambda_BC$lambda) - 1) / 
#                          lambda_BC$lambda)
# 
# 
# model <- aov(formula = bcmape ~ size_dataset + 
#                lookback + size_dataset:lookback,
#              data = df)
# 
# 
# summary(model)
# 
# #Observando os parâmetros do modelo_tempodist
# 
# par(mfrow=c(2,2))
# 
# plot(model)
# 
# par(mfrow=c(1,1))
# 
# hist(model$residuals)

shapiro.test(model$residuals)

summary(model)

TukeyHSD(model)

par(mfrow=c(1,1))
boxplot(df$mape ~df$volume)
boxplot(df$mape ~df$lookback)

# #Outras maneiras de apresentar os outputs do modelo
# #função 'summ' do pacote 'jtools'
# summ(model, confint = T, digits = 4, ci.width = .95)
# export_summs(model, scale = F, digits = 4)
# 
# #Visualização do modelo no ambiente Viewer
# #função 'extract_eq' do pacote 'equatiomatic'
# extract_eq(model, use_coefs = T) %>%
#   kable() %>%
#   kable_styling(bootstrap_options = "striped",
#                 full_width = F,
#                 font_size = 28)
# 
# #Salvando fitted values (variável yhat) e residuals (variável erro) no dataset
# df$yhat <- model$fitted.values
# df$erro <- model$residuals
# 
# #Visualizando a base de dados com as variáveis yhat e erro
# df %>%
#   select(size_dataset, lookback, mape, yhat, erro) %>%
#   kable() %>%
#   kable_styling(bootstrap_options = "striped", 
#                 full_width = F, 
#                 font_size = 22)
# 
# write.csv(df, file='df_excel.csv')
