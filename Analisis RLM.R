#######################################################

## Analisis Regresion lineal multiple ##

#######################################################


### librerias ###
library(tidyverse)
library(tidymodels)
library(here)
library(readxl)
library(ISLR)

### carga de datos ###
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
transit_cost <- readxl::read_xlsx('transit_cost.xlsx')
View(transit_cost) 
class(transit_cost)
transit_cost

### analisis bivariado de las variable real_cost con todas las variables independientes ### 
correlaciones <- data.frame()

#start_year
ggplot(data = transit_cost,
       mapping = aes(x = start_year, y = real_cost)) +
  geom_point(size = 3, col = 'red', alpha = 0.6) +
  labs(x = 'Año de inicio del proyecto',
       y = 'Costo real del proyecto',
       title = 'Relación entre el año de inicio del proyecto y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$start_year, method = c("pearson"))
correlaciones <- cbind('start_year' = correlacion)
#end_year
ggplot(data = transit_cost,
       mapping = aes(x = end_year, y = real_cost)) +
  geom_point(size = 3, col = 'blue', alpha = 0.6) +
  labs(x = 'Año de termino del proyecto',
       y = 'Costo real del proyecto',
       title = 'Relación entre el año de termino del proyecto y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$end_year, method = c("pearson"))
correlaciones <- cbind(correlaciones,'end_year' = correlacion)
#rr
ggplot(data = transit_cost,
       mapping = aes(x = rr, y = real_cost)) +
  geom_point(size = 3, col = 'pink', alpha = 0.6) +
  labs(x = 'Presencia o no de via ferrea',
       y = 'Costo real del proyecto',
       title = 'Relación entre proyecto con/sin via ferrea y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$rr, method = c("pearson"))
correlaciones <- cbind(correlaciones,'rr'= correlacion)

#Length, corr > 0.3
ggplot(data = transit_cost,
       mapping = aes(x = length, y = real_cost)) +
  geom_point(size = 3, col = 'orange', alpha = 0.6) +
  labs(x = 'Longitud de la linea en KM',
       y = 'Costo real del proyecto',
       title = 'Relación entre la longitud de la linea y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$length, method = c("pearson"))
correlaciones <- cbind(correlaciones,'length'= correlacion)

#tunnel_per, transformando primero de string a porcentaje numerico
transit_cost$tunnel_percent <- as.numeric(substr(transit_cost$tunnel_per,1,nchar(transit_cost$tunnel_per)-1))/100
ggplot(data = transit_cost,
       mapping = aes(x = tunnel_percent, y = real_cost)) +
  geom_point(size = 3, col = 'black', alpha = 0.6) +
  labs(x = 'Porcentaje de la linea completado',
       y = 'Costo real del proyecto',
       title = 'Relación entre el porcentaje completado de la linea y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$tunnel_percent, use = "pairwise.complete.obs" ,method = c("pearson"))
correlaciones <- cbind(correlaciones,'tunnel_per'= correlacion)


#tunnel, cor > 0.3
ggplot(data = transit_cost,
       mapping = aes(x = tunnel, y = real_cost)) +
  geom_point(size = 3, col = 'darksalmon', alpha = 0.6) +
  labs(x = 'KMs de la linea finalizados',
       y = 'Costo real del proyecto',
       title = 'Relación entre los KM de la linea finalizados y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$tunnel, method = c("pearson"))
correlaciones <- cbind(correlaciones,'tunnel'= correlacion)

#stations, cor > 0.3
ggplot(data = transit_cost,
       mapping = aes(x = stations, y = real_cost)) +
  geom_point(size = 3, col = 'green3', alpha = 0.6) +
  labs(x = 'Número de estaciones',
       y = 'Costo real del proyecto',
       title = 'Relación entre el número de estaciones y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$stations, method = c("pearson"))
correlaciones <- cbind(correlaciones,'stations'= correlacion)

#cost
ggplot(data = transit_cost,
       mapping = aes(x = cost, y = real_cost)) +
  geom_point(size = 3, col = 'violetred', alpha = 0.6) +
  labs(x = 'Costo en millones según moneda local',
       y = 'Costo real del proyecto',
       title = 'Relación entre el costo en millones según moneda local y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$cost, method = c("pearson"))
correlaciones <- cbind(correlaciones,'cost'= correlacion)

#year
ggplot(data = transit_cost,
       mapping = aes(x = year, y = real_cost)) +
  geom_point(size = 3, col = 'purple3', alpha = 0.6) +
  labs(x = 'Año medio de construcción',
       y = 'Costo real del proyecto',
       title = 'Relación entre el año medio de construcción y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$year, method = c("pearson"))
correlaciones <- cbind(correlaciones,'year'= correlacion)

#ppp_rate
ggplot(data = transit_cost,
       mapping = aes(x = ppp_rate, y = real_cost)) +
  geom_point(size = 3, col = 'darkgreen', alpha = 0.6) +
  labs(x = 'PPA basada en el punto medio de la construcción',
       y = 'Costo real del proyecto',
       title = 'Relación entre el PPA basada en el punto medio de la construcción y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$ppp_rate, use = "pairwise.complete.obs",method = c("pearson"))
correlaciones <- cbind(correlaciones,'ppp_rate'= correlacion)

#cost_km_millions
ggplot(data = transit_cost,
       mapping = aes(x = cost_km_millions, y = real_cost)) +
  geom_point(size = 3, col = 'darkred', alpha = 0.6) +
  labs(x = 'Costo por KM en millones de dolares',
       y = 'Costo real del proyecto',
       title = 'Relación entre el costo por KM en millones de dolares y el costo real',
       subtitle = 'Periodo 1982-2020')

correlacion <- cor(transit_cost$real_cost, transit_cost$cost_km_millions,use = "pairwise.complete.obs", method = c("pearson"))
correlaciones <- cbind(correlaciones,'cost_km_millions'= correlacion)
View(correlaciones)

### Seleccionamos aquellas variables que tengan correlacion mayor a 0.3 ###
data_cost <-
  transit_cost %>% 
  dplyr::select('real_cost','length','tunnel','stations')



### Ajuste del modelo de regresion lineal multiple ###

#Plantamos semilla para obtener resultados reproducibles
set.seed(3707)

#Nos interesa saber la proporcion de estaciones en cada proyecto
data_cost %>% 
  dplyr::count(stations) %>% 
  dplyr::mutate(prop = n/ sum(n))

### Modelo ###
## Data splitting ##
split_info <- rsample::initial_split(
  data = data_cost,
  prop = 0.75,
  strata = stations)

cost_train <- rsample::training(split_info)
cost_test <- rsample::testing(split_info)

## Feature enginering ##
model_recipe <- recipe(real_cost ~., data = cost_train) %>% 
  step_scale(all_predictors())
summary(model_recipe)

## Model especification ##
default_model <-
  parsnip::linear_reg() %>% 
  set_engine('lm') %>% 
  set_mode('regression')

## Create a workflow ##
model_wf <- 
  workflow() %>% 
  add_model(default_model) %>% 
  add_recipe(model_recipe)

## Fit the model ##
model_fit <- 
  model_wf %>% 
  fit(data = cost_train)

tidy(model_fit)

## Evaluate performance model ##
prediction_model <- predict(model_fit, new_data = cost_test)
prediction_model

data_pred_test = cost_test %>% 
  bind_cols(prediction_model)

### Reportamos medias de bondad de ajuste ###

#r2
rsq(data_pred_test, truth = real_cost, estimate = .pred)

#MAPE
mape(data = data_pred_test,real_cost,.pred)
min(data_pred_test$real_cost)
#MAE
mae(data = data_pred_test,real_cost,.pred)

##grafico de dispersion entre el costo real del proyecto y su valor predicho

ggplot(data = data_pred_test,
       mapping = aes(x = .pred, y = real_cost)) +
  geom_point(size = 3, col = 'red', alpha = 0.6) +
  labs(x = 'Costos predichos del proyecto',
       y = 'Costos reales del proyecto',
       title = 'Gráfico de dispersión entre costo predicho y real') + 
  geom_abline()

### Realizamos una validacion cruzada ###

#10 folds cross validations
data_folds = vfold_cv(cost_train, v=10, strata = 'stations')
data_folds

#Fit Model to resample data
ctrl_preds = control_resamples(save_pred = TRUE)

#Fit
fit_folds = fit_resamples(model_wf, resamples = data_folds, control = ctrl_preds)
head(fit_folds)

fit_folds$splits[[1]]%>%analysis() 

fit_folds%>%collect_predictions() 

fit_folds%>%collect_metrics()
data_10_folds <- fit_folds%>%collect_predictions()

### Reportamos medias de bondad de ajuste ###

# R2 tras vfold
rsq(data_10_folds, truth = real_cost, estimate = .pred)

# MAPE tras vfold
mape(data = data_10_folds, real_cost,.pred)

#MAE

mae(data = data_10_folds, real_cost,.pred)