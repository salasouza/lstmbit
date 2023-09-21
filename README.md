# LSTM Bit

## RNN to applied cryptocurrency

## Structure of project: 

```pipeline
.
├── database
│   ├── row
│   └── trusted
├── lstm
├── notebook
├── output
│   ├── experiment
│   │   ├── 1_year
│   │   ├── 3_years
│   │   ├── 5_years
│   │   └── better_results
│   └── statistics
├── pictures
├── recicle
│   ├── database
│   └── output
│       ├── otimization
│       ├── plots_lookback_32_batch
│       └── plots_lookback_64_batch
├── scripts
└── utils

 ```

## Scientific Method

```mermaid
graph LR;
    Problem-->Objective;
    Objective-->Method;
    Method-->Results;
    Results-->Discussion;
```

## To Build enviroment in Anaconda
 
 ```
 conda create --name "name_env" python=3.9.13
 conda info --envs
 conda activate "nome_env"
 conda deactivate
 source ~/.bashrc  # init anaconda base
 ```
## Scripts 

```
source env_init.sh          # To initialization the enviroment
source stopped_env.sh       # Deactivating the enviroment
source lab_init.sh          # To initialization the notebook
source git_init.sh          # To commit code
```

 ## Build script Shell
```
chmod +x "name_script.sh"
```