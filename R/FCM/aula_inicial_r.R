x = c(1,2,3)
y = c(2, 4, 6)
plot(x,y)

getwd()

dados <- read.csv("C:/Users/moise/Desktop/UNESP/MESTRADO/Disciplinas/FCM/R/FCM/Pokemon_full.csv")

head(dados) # mostra as primeiras linhas
tail(dados,12) # mostra as ultimas linhas

View(dados)

library(tidyverse)

names(dados)

# seleciona colunas
select(dados, name, hp, speed, attack)

# filtra colunas
filter(dados, attack < 50)

# operações

mutate(dados, x = attack+speed) # cria nova variável
mutate(dados, attack = attack/2) # modifica variável
mutate(dados, IMC = weight/(height*height))

dados <- mutate(dados, IMC = weight/(height*height)) # modifica variável

# exemplo operador

# Sem uso de pipe [%>%] 
df <- select(dados, name, hp, attack, speed) 
df <- filter(df, attack < 50) 
df <- mutate(df, x = attack+speed) 

# Com uso de pipe [%>%], normalmente mais rapido, tudo o que esta a esquerda do pipe ele vai pegar e atribuir como primeiro argumento da função seguinte
df <- dados %>%
  select(name, hp, attack, speed) %>%
  filter(attack < 50) %>%
  mutate(x = attack+speed) 

# gsub modifica strings, ou seja, caracters  
x = c("Luana", "Moises", "Barbara")
# Se colocar ponto, o pipe rastreia e substitui. Se nao colocar, ele coloca como primeiro argumento   
x %>%
gsub("Lu","lu", .)

# l>: pipe nativo do R, mas nao substitui 


dados %>%
  filter(height > 10) %>%
  select(name, height, weight) %>%
  mutate(imc = weight/(height*height)) %>%
  ggplot()+
  geom_density(aes( x = imc))

head(dados)
dados %>% head

#comando interessante - "comando geral"
glimpse(dados)

#comandos interessantes
dados %>% pull(IMC) # retorna como vetor, em array
dados %>% select(IMC) # retorna uma coluna

mean(c(1,2,3,4))

dados %>% 
  mutate(media = mean(IMC)) # cria e preenche uma coluna com o mesmo valor

dados %>% 
  summarise(media = mean(IMC), desvio = sd(IMC)) # retorna uma unica coluna, com o valor da media. Resume os dados, retornando uma coluna para cada variavel. 

dados %>% 
  group_by(type) %>% 
  summarise(media = mean(IMC), desvio = sd(IMC)) # retorna uma unica coluna, com o valor da media. Resume os dados, retornando uma coluna para cada variavel. 

dados %>% 
  group_by(type) %>% 
  mutate(media = mean(IMC)) %>% View # cria e preenche uma coluna com o mesmo valor

# Como utilizar os comandos acima com meus dados reais:
# Caso eu queira filtrar meus dados, pegando só individuos com IMC > média do grupo dele:
  dados %>% 
  group_by(type) %>% 
  mutate(media = mean(IMC)) %>%  
  filter(IMC > media) %>% View 

# Tudo o que for aplicado aqui, sera aplicado por grupo
df <- dados %>% 
    group_by(type) %>% 
    mutate(media = mean(IMC)) 

df %>% 
  mutate(media2 = mean(IMC)) %>% View 

# Como desagrupar?
df %>% 
  ungroup() %>% 
  mutate(media2 = mean(IMC)) %>% View

# Busca padrões
# aceita Regular Expression (ReGex) # pode variar de acordo com o que colocar
grep("saur|fly", dados$name) # retorna a posição que tem
grepl("saur|fly", dados$name) # retorna com True and False

# Com (ReGex), é possível procurar por um ou por outro
grep("[Ss]aur", dados$name) 

x
grep("Lua", x) 

# Com (ReGex), quando coloca . significa qualquer coisa, para encontrar de fato o ., é necessário colocar "\\."
grepl(".", c("a", "b", "c", "0", " "))

dados %>%
  filter(attack > 50)

dados$attack > 50

dados %>%
  filter(grepl("saur|fly", name), attack > 50, type != "grass")

"saur" == "ivysaur"
grepl("saur", "ivysaur")

==================================================
# Juntar dois data frames, juntando dados [juntar linhas ou juntar colunas]
  
# bind row
df1 <- dados %>%
  filter(attack > 70)

df2 <- dados%>%
  filter(attack <= 70)

rbind(df1, df2) # juntar linhas, nao aceita dimensoes e nomes diferentes

# com colunas diferentes
df1 <- dados %>%
  select(attack, speed, weight) %>%
  filter(attack > 70)

df2 <- dados%>%
  select(attack, weight, height, hp) %>%
  filter(attack <= 70)

bind_rows(df1, df2) # juntar linhas, completa se não bater 

# Juntar Colunas 
df1 <- dados %>% head(100)
df2 <- dados %>% tail(100)

cbind(df1, df2) %>% names

bind_cols(df1, df2, .nane_repair = "unique")

# ====================================================

# Fazendo join
# left, right, full, inner

df_resumo <- dados %>% 
  group_by(type) %>% 
  summarise(media = mean(IMC), desvio = sd(IMC)) 

left_join(dados, df_resumo, by = "type") %>% View
left_join(dados, df_resumo, by = "type", "secondary.type") %>% View

# left, right, full, inner: diferença caso tenha coisas faltando nos dados

df_resumo_mis <- df_resumo %>% filter(type != "grass")

left_join(dados, df_resumo_mis, by = c("type")) %>% View # tem coisas nos "dados" que nao tem no df_resumo mas ele completa. 
right_join(dados, df_resumo_mis, by = c("type")) %>% View # as coisas que estao nos "dados" são excluidas, ele mantem apenas o que tem na direita, ou seja, apenas o que tem no arquivo "df_resumo". 

# mantem tudo: full
# joga fora tudo: iner

full_join(dados, df_resumo_mis, by = c("type")) %>% View # tem coisas nos "dados" que nao tem no df_resumo mas ele completa. 
inner_join(dados, df_resumo_mis, by = c("type")) %>% View # as coisas que estao nos "dados" são excluidas, ele mantem apenas o que tem na direita, ou seja, apenas o que tem no arquivo "df_resumo". 

#===============================================================================


