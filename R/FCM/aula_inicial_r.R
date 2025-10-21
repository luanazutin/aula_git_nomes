x = c(1,2,3)
y = c(2, 4, 6)
plot(x,y)

getwd()

dados <- read.csv("C:/Users/moise/Desktop/UNESP/MESTRADO/Disciplinas/FCM/R/FCM/Pokemon_full.csv")

head(dados) # mostra as primeiras linhas
tail(dados,12) # mostra as ultimas linhas

library(tidyverse)

names(dados)

# seleciona colunas
select(dados, name, hp, speed, attack)

# filtra colunas
filter(dados, attack < 50)

# operações

mutate(dados, x = attack+speed) # cria nova variável
mutate(dados, attack = attack/2) # modifica variável

dados %>%
  select(name, hp, attack, speed) %>%
  filter(attack < 50) %>%
  mutate(x = attack+speed) 

x = c("Luana", "Moises")

x %>%
  gsub("Lu", .)




