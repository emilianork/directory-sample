FactoryBot.define do
  factory :contact do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    phone       { Faker::PhoneNumber.phone_number }

    address do
      "#{Faker::Address.street_address}, " \
        "#{Faker::Address.city}, #{Faker::Address.zip_code}"
    end

    user
  end
end
