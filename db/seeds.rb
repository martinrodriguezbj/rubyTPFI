# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

#crear 2 localidades
Locality.create(locality: "Saladillo", province: "Buenos Aires")
Locality.create(locality: "Lobos", province: "Buenos Aires")



bank1 = Bank.create(name:"Banco de la Nacion", address: "Av Arequipa 123", phone: "123456789", locality_id: 1)
bank2 = Bank.create(name:"Banco de Credito", address: "Av Arequipa 123", phone: "123456789", locality_id: 1)
bank3 = Bank.create(name:"Banco de la Provincia", address: "Av Arequipa 123", phone: "123456789", locality_id: 2)

@schedule1 = Schedule.new(day: "Monday", startAttention: nil, endAttention: nil)
@schedule2 = Schedule.new(day: "Tuesday", startAttention: nil, endAttention: nil)
@schedule3 = Schedule.new(day: "Wednesday", startAttention: nil, endAttention: nil)
@schedule4 = Schedule.new(day: "Thursday", startAttention: nil, endAttention: nil)
@schedule5 = Schedule.new(day: "Friday", startAttention: nil, endAttention: nil)

bank1.schedules << @schedule1
bank1.schedules << @schedule2
bank1.schedules << @schedule3
bank1.schedules << @schedule4
bank1.schedules << @schedule5

@schedule1 = Schedule.new(day: "Monday", startAttention: nil, endAttention: nil)
@schedule2 = Schedule.new(day: "Tuesday", startAttention: nil, endAttention: nil)
@schedule3 = Schedule.new(day: "Wednesday", startAttention: nil, endAttention: nil)
@schedule4 = Schedule.new(day: "Thursday", startAttention: nil, endAttention: nil)
@schedule5 = Schedule.new(day: "Friday", startAttention: nil, endAttention: nil)

bank2.schedules << @schedule1
bank2.schedules << @schedule2
bank2.schedules << @schedule3
bank2.schedules << @schedule4
bank2.schedules << @schedule5

@schedule1 = Schedule.new(day: "Monday", startAttention: nil, endAttention: nil)
@schedule2 = Schedule.new(day: "Tuesday", startAttention: nil, endAttention: nil)
@schedule3 = Schedule.new(day: "Wednesday", startAttention: nil, endAttention: nil)
@schedule4 = Schedule.new(day: "Thursday", startAttention: nil, endAttention: nil)
@schedule5 = Schedule.new(day: "Friday", startAttention: nil, endAttention: nil)

bank3.schedules << @schedule1
bank3.schedules << @schedule2
bank3.schedules << @schedule3
bank3.schedules << @schedule4
bank3.schedules << @schedule5

#crear 1 usuario administrador
usuario = User.create(username: "admin", password_digest: BCrypt::Password.create("Usuario123",cost:5), roll: "Administrador", name: "Steve", surname: "Jobs", phone: "123456789", address: "Calle falsa 123", email: "stevejobs@gmail.com")
usuario.add_role("Administrador")

#crear 3 usuarios personal bancario
usuario = User.create(username: "personal1", password_digest: BCrypt::Password.create("Usuario123",cost:5), roll: "Personal bancario", bank_id: 1, name: "Lionel", surname: "Messi", phone: "123456789", address: "Calle falsa 123", email: "messi@gmail.com")
usuario.add_role("Personal bancario")
usuario = User.create(username: "personal2",password_digest: BCrypt::Password.create("Usuario123",cost:5), roll: "Personal bancario", bank_id: 2, name: "Cristiano", surname: "Ronaldo", phone: "123456789", address: "Calle falsa 123", email: "cristiano@gmail.com")
usuario.add_role("Personal bancario")
usuario = User.create(username: "personal3", password_digest: BCrypt::Password.create("Usuario123",cost:5), roll: "Personal bancario", bank_id: 3, name: "Neymar", surname: "Junior", phone: "123456789", address: "Calle falsa 123", email: "neymar@gmail.com")
usuario.add_role("Personal bancario")

#crear 3 usuarios cliente
#cost significa el costo computacional que conlleva la encriptacion de la contraseña
usuario = User.create(username: "cliente1", password_digest: BCrypt::Password.create("Usuario123",cost:5), roll: "Cliente", bank_id: 1, name: "Roman", surname: "Riquelme", phone: "123456789", address: "Calle falsa 123", email: "roman@gmail.com")
usuario.add_role("Cliente")
usuario = User.create(username: "cliente2", password_digest: BCrypt::Password.create("Usuario123",cost:5), roll: "Cliente", bank_id: 2, name: "Diego", surname: "Maradona", phone: "123456789", address: "Calle falsa 123", email: "maradona@gmail.com")
usuario.add_role("Cliente")
usuario = User.create(username: "cliente3", password_digest: BCrypt::Password.create("Usuario123",cost:5), roll: "Cliente", bank_id: 3, name: "Diego", surname: "Forlan", phone: "123456789", address: "Calle falsa 123", email: "forlan@gmail.com")
usuario.add_role("Cliente")

