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



Bank.create(name:"Banco de la Nacion", address: "Av. Arequipa 123", phone: "123456789", locality_id: 1)
Bank.create(name:"Banco de Credito", address: "Av. Arequipa 123", phone: "123456789", locality_id: 1)
Bank.create(name:"Banco de la Provincia", address: "Av. Arequipa 123", phone: "123456789", locality_id: 2)

#crear 1 usuario administrador
usuario = User.create(username: "admin", password_digest: "1234", roll: "Administrador", name: "Steve", surname: "Jobs", phone: "123456789", address: "Calle falsa 123", email: "stevejobs@gmail.com")
usuario.add_role("Administrador")

#crear 3 usuarios personal bancario
usuario = User.create(username: "personal1", password_digest: "1234", roll: "Personal bancario", bank_id: 1, name: "Lionel", surname: "Messi", phone: "123456789", address: "Calle falsa 123", email: "messi@gmail.com")
usuario.add_role("Personal bancario")
usuario = User.create(username: "personal2", password_digest: "1234", roll: "Personal bancario", bank_id: 2, name: "Cristiano", surname: "Ronaldo", phone: "123456789", address: "Calle falsa 123", email: "cristiano@gmail.com")
usuario.add_role("Personal bancario")
usuario = User.create(username: "personal3", password_digest: "1234", roll: "Personal bancario", bank_id: 3, name: "Neymar", surname: "Junior", phone: "123456789", address: "Calle falsa 123", email: "neymar@gmail.com")
usuario.add_role("Personal bancario")

#crear 3 usuarios cliente
usuario = User.create(username: "cliente1", password_digest: "1234", roll: "Cliente", bank_id: 1, name: "Roman", surname: "Riquelme", phone: "123456789", address: "Calle falsa 123", email: "roman@gmail.com")
usuario.add_role("Cliente")
usuario = User.create(username: "cliente2", password_digest: "1234", roll: "Cliente", bank_id: 2, name: "Diego", surname: "Maradona", phone: "123456789", address: "Calle falsa 123", email: "maradona@gmail.com")
usuario.add_role("Cliente")
usuario = User.create(username: "cliente3", password_digest: "1234", roll: "Cliente", bank_id: 3, name: "Diego", surname: "Forlan", phone: "123456789", address: "Calle falsa 123", email: "forlan@gmail.com")
usuario.add_role("Cliente")

