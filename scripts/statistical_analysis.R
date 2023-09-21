#'-------------------------------------------------------------------
#' Datasets
#'-------------------------------------------------------------------

#' Setup

setwd("D:/Projects/lstmbit")

#' 
pacman::p_load("plotly","tidyverse","ggrepel","fastDummies",
               "knitr","kableExtra","splines","reshape2",
               "PerformanceAnalytics","correlation","see",
               "ggraph","psych","nortest","rgl","car",
               "ggside","tidyquant","olsrr","jtools",
               "ggstance","magick","cowplot","emojifont",
               "beepr","Rcpp","equatiomatic")

#' Loangind dataset
list.files()
df = readRDS("wandb_ex.RData"); head(df)

df <- df[,-1]; df

write.csv(df, file='dataset.csv')

#' Statistical Analysis

model <- aov(formula = mape ~ volume + lookback + volume:lookback,
             data = df)

model
summary(model)
results <- anova(model); results

par(mfrow=c(2,2))
plot(model)

par(mfrow=c(1,2))
plot(TukeyHSD(model))

posHoc <- TukeyHSD(model)

posHoc$volume

posHoc$volume %>% 
  as.data.frame() %>% 
  write.csv(file = "poshoc_volume.csv")

posHoc$lookback

posHoc$lookback %>% 
  as.data.frame() %>% 
  write.csv(file = "poshoc_lookback.csv")

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

#' Report

# load package
pacman::p_load("sjPlot","sjmisc","sjlabelled")

anova(model) %>% 
  as.data.frame() %>% 
  write.csv(file = "wandb_anova_table.csv")

tab_model(results, auto.label = TRUE)

capture.output(summary(model),file="wandb_analysis.csv")

# tab_model(model, auto.label = FALSE, file='wandb_analysis.csv')

df%>%filter(mape <= 2.5)

saveRDS(wandb_ex, file='wandb_ex.RData')

save.image("mba_tcc.RData")

#' Wandb
#' 

res <- wandb%>%filter(mape <= 2.5); res

write.csv(res, 'resultados.csv')
