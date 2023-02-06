# README

Los 3 tipos de usuarios comparten el mismo modelo Users por que no creí necesario crear otro modelo solo para 
el personal bancario, que solo difiere en un campo con el resto de usuarios.

Una persona y un banco pueden tener muchos turnos y un turno corresponde unicamente a una persona y un banco. En el turno se guarda el id de aquel personal bancario que lo atendió, pero no existe una relacion fuerte.
La manera de cancelar un turno que elegí es la de eliminarlo totalmente del sistema.

Un banco pertenece a una única localidad, y esta puede albergar muchos bancos.
Una localidad que ya alberga un banco no puede ser eliminada del sistema, lo mismo un banco que ya tenga empleados tampoco puede ser eliminado.
Cada banco al crearse genera los horarios para los 5 días habiles de la semana (lunes a viernes), con horarios en nil. Una vez creado el banco el administrador podrá editar los horarios del mismo.

Para hacer funcionar la aplicación habrá que instalar las gemas con bundle install, y luego solo hay que correr rails .
Se incluyeron un conjunto de datos de prueba para poder evaluar el sistema.
Estos seeds se deben cargar con el comando: rails db:seed