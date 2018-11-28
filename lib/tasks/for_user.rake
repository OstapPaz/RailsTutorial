require 'faker'

namespace :for_user do
  desc "adding users to db"
  task adds: :environment do
    pass = Faker::Internet.password(8)


    unless User.find_by(name: "Bruce Wayne")
    User.create(name: "Bruce Wayne",
                email: Faker::Internet.email,
                activated: true,
                admin: true,
                password: pass, password_confirmation: pass)
    end



    24.times do
      pass = Faker::Internet.password(8)
      User.create(name: Faker::Name.name,
                  email: Faker::Internet.email,
                  activated: true,
                  password: pass, password_confirmation: pass)
    end

  end

  desc "delete users from db"
  task delete: :environment do
    User.where(admin: false).destroy_all
  end

end
