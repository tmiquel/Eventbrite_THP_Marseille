# frozen_string_literal: true

Rails.application.eager_load!
models_array = [User, Event, Attendance]
# Sets the locale to "France":
Faker::Config.locale = 'fr'

puts "Deleting Database for the following models: #{models_array.join(' ')}."
puts '-' * 50
puts
models_array.each(&:destroy_all)
Faker::UniqueGenerator.clear
puts 'Done'
puts
puts 'Reinitiating tables index at  1'
puts
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end
puts '-' * 50
puts
puts 'Done'
puts
puts "Database generation for #{models_array.join(' ')}"
puts '-' * 50
puts

models_items_count = Hash[[['User', 5], ['Event', 10], ['Attendance', 20]]]
pic_path = Dir.getwd+'/lib/assets/simple_neuron.png'
models_array.each do |model|
  puts "Generating #{models_items_count[model.name]} items for #{model.name}"
  models_items_count[model.name].times do
    case model.name
    # when 'City'
    #   model.create(name: Faker::Nation.capital_city,
    #                zip_code: Faker::Number.number(5).to_s)

    when 'User'
      password = Faker::Internet.password(13, 25, true, true)
      email = Faker::Internet.unique.email

      puts "The password of User #{email} is #{password}"

      model.create(first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   email: email,
                   description: Faker::Lorem.paragraph_by_chars(256, false),
                   password: password,
                   password_confirmation: password)

    when 'Event'
      e = model.new(admin: User.all.sample,
                   title: Faker::Lorem.paragraph_by_chars(50, false),
                   start_date: Faker::Date.forward(365),
                   duration: rand(1..10) * 5,
                   description: Faker::Lorem.paragraph_by_chars(256, false),
                   price: rand(1..1000),
                   location: Faker::Nation.capital_city)

      e.picture.attach(io: File.open(pic_path), filename: ("picture " + e.title.to_s + ".png"))

      e.save

    when 'Attendance'
      model.create(attendee: User.all.sample,
                   event: Event.all.sample,
                   stripe_customer_id: Faker::Number.unique.number(10))
    end
  end
end

puts 'Done'
puts
puts 'View of the last 3 items for all tables'
puts '-' * 50
puts

models_array.each do |model|
  puts "#{model.name} : #{model.count} items"
  unless models_items_count[model.name] == model.count
    puts "ISSUE of Validation ? the number of generated items differs from the requested one: #{models_items_count[model.name]}"
  end
  puts
  tp model.last(3)
  puts
end
