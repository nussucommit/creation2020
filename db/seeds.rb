# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

challenge = challenge_statements.create!(title: "Challenge Statement 1", partner_name: "NUSSU Welfare", description: "Description for CS1")
challenge.zip.attach(io: File.open('app/assets/seed/Challenge 1 Brief - 2020 NUSSU Welfare Diary.pdf'), filename: 'Challenge 1 Brief - 2020 NUSSU Welfare Diary.pdf')
challenge = challenge_statements.create!(title: "Challenge Statement 2", partner_name: "NUS IT", description: "Description for CS2")
challenge.zip.attach(io: File.open('app/assets/seed/Challenge 2 Brief - Key Visual for NUS Commencement Class Giving 2021.pdf'), filename: 'Challenge 2 Brief - Key Visual for NUS Commencement Class Giving 2021.pdf')
challenge = challenge_statements.create!(title: "Challenge Statement 3", partner_name: "NUS DVO", description: "Description for CS3")
challenge.zip.attach(io: File.open('app/assets/seed/Challenge 3 Brief - Mascot for NUS IT Security Awareness Campaign.pdf'), filename: 'Challenge 3 Brief - Mascot for NUS IT Security Awareness Campaign.pdf')


#(1..10).each do |n|
#  name = Faker::Name.unique.name
#  email = "#{name.gsub(/[^a-z0-9]/i, '')}#{n}@u.nus.edu"
#User.create!(name: name,
#            matrix_number: "A0189174R",
#            faculty: "School Of Computing",
#            year: "Year 1",
#            contact_number: "84265038",
#            email: email,
#            password: "password",
#            password_confirmation: "password")
#
#end
