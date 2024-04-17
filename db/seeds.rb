# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(email: 'patient2@example.com', password: 'password', role: :patient, first_name: 'Anna', last_name: 'Bąk', pesel_number: '35476192890')
User.create!(email: 'admin@example.com', password: 'password', role: :admin, first_name: 'Zenon', last_name: 'Kowalski', pesel_number: '54890912890')
User.create!(email: 'labworker@example.com', password: 'password', role: :labworker, first_name: 'Renata', last_name: 'Klucz', pesel_number: '48901292890')
User.create!(email: 'tomasz.kowalczyk@example.com', password: 'password', role: :doctor, first_name: 'Tomasz', last_name: 'Kowalczyk', pesel_number: '99035089710')
User.create!(email: 'aleksandra.nowak@example.com', password: 'password', role: :doctor, first_name: 'Aleksandra', last_name: 'Nowak', pesel_number: '73489089710')
User.create!(email: 'marta.lewandowska@example.com', password: 'password', role: :doctor, first_name: 'Marta', last_name: 'Lewandowska', pesel_number: '39447891232')


