FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { '123456' }
    role { :user }

    trait :invalid do
      first_name { nil }
      last_name { nil }
      email { nil }
    end
  end

  factory :admin, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { '12345678' }
    password_confirmation { '12345678' }
    role { :admin }
  end
end
