# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Los 3 tipos de usuarios comparten el mismo modelo Users por que no creí necesario crear otro modelo solo para 
el personal bancario, que solo difiere en un campo con el resto de usuarios.
Una persona puede tener muchos turnos y un turno corresponde unicamente a una persona. En el turno se guarda el id de aquel personal bancario que lo atendió, pero no existe una relacion fuerte
Un banco pertenece a una única localidad, y esta albergar muchos bancos
Cada banco al crearse genera los horarios para los 5 días habiles de la semana (lunes a viernes), con horarios en nil. Una vez creado el banco el administrador podrá editar los horarios del mismo

Para hacer funcionar la aplicación habrá que instalar las gemas con bundle install, y luego solo hay que correr rails 
para cargar los seeds: rails db:seed
por alguna razón que desconozco hasta el día de la entrega, los usuarios creados por seed no se crean con la contraseña hasheada, entonces no me permite logearme con ellos, tengo que crear un usuario admin desde el front y con el cambiarle la contraseña a los usuarios creados desde el seed para así poder acceder con ellos también

Tampoco pude ocultar enlaces que no corresponden a ciertos roles, cancancan me ocacionó algunos problemas. pero las rutas estan debidamente protegidas de todas formas