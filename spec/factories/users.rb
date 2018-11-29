FactoryBot.define do
    factory :user do
        name { Faker::Name.name }
        email 'some@thing.de'
        password 'somepass'
    end
end