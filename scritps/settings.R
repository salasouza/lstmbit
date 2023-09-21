#'---------------------------------------------------------
#' 
#' Settings Enviroment
#' 
#'---------------------------------------------------------

#' Setup

setwd("D:/Projects/RNNcrypto/dados_tcc/tcc_mba")
save.image('mba.RData')
load('mba.RData')

#' Enter of data
wandb_ex <- read.csv(file='df_resumed.csv',
                     header=TRUE,
                     sep=',',
                     stringsAsFactors = TRUE)

wandb <- read.csv(file='mba_resumed.csv',
                     header=TRUE,
                     sep=',',
                     stringsAsFactors = TRUE)

#' Save Dataset:
#' 
saveRDS(wandb, file='wandb_ex.RData')
saveRDS(wandb_ex, file='wandb.RData')

list.files()

df = readRDS("wandb_ex.RData"); head(df)