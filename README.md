# Regresion Lineal Multiple
 A partir de un modelo de regresión lineal múltiple, se intentará modelar el costo real del proyecto de tránsito en función de variables predictoras.

A partir de los gráficos y de los valores obtenidos en las correlaciones se pueden obtener
numerosas conclusiones. Primero, observando los gráficos de start_year, end_year y year
se puede ver que hay una ligera tendencia al alza en el costo real, lo cual probablemente no
se deba al aumento de los años en sí mismo sino que a la inflación ya que la moneda es
nominal.
Segundo, para la variable rr, a pesar de que en el gráfico se puede ver que algunos
proyectos efectivamente tienen costos más altos, la correlación nos muestra que en el total,
esto es usando los valores que no se ven fácilmente en el gráfico, resulta que la correlación
es negativa, pero muy chica por lo que no se puede concluir mucho al respecto.
Tercero, a partir de las variables length y tunnel se corrobora la intuición de que a mayor
cantidad construida y mayor cantidad a construir implican mayores costos, pero al ver el
porcentaje de avance de la construcción en la variable tunnel_per es muy chico y de signo
negativo, lo que o bien indica que la mayor parte de los costos se incurren al principio o que
se encuentra mayormente explicado por tunnel y length.
Cuarto, se cumple que a mayor número de estaciones mayor es el costo incurrido,
evidenciado en la clara tendencia en el gráfico y en la alta correlación. Quinto, se cumple la
intuición de que el costo nominal sin cambiar por tipo de cambio tiene una correlación muy
baja ya que compara números de magnitudes completamente diferentes como iguales.
Sexto, se puede ver que la diferencia dada por el poder de paridad de compra de cada lugar
es muy chico y negativo lo que quiere decir que el costo de construcción en sí mismo no
varía significativamente. Por último se cumple la expectativa con una correlación moderada
que a medida que aumenta el costo por kilómetro, el costo total de la inversión también va a
aumentar.

Para el modelo se decidio utilizar strata = stations debido a que aumentaba
significativamente el R2 obtenido. Del resultado obtenido podemos notar que todas
las variables son significativas estadísticamente al 5%, pero el intercepto no es
estadísticamente distinto de 0. De todas maneras dado que su coeficiente estimado
se encuentra cercano a 0 en comparación con la magnitud de las otras variables
esto no afectará tan fuertemente el resultado final.

Dado que el MAPE (‘Mean Absolute Percentage Error’) da Inf debido que existen
valores reales iguales a 0 en la muestra (los 0 se deben a que hay proyectos que
aún no comienzan, por ende, todavia no hay un costo real del proyecto), se indica el
MAE (‘Mean Absolute Error’) para comparar posteriormente.
Por lo tanto, en promedio el modelo estima con una diferencia de 1722 millones de
dólares el costo real del proyecto.
