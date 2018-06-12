FactoryBot.define do
  factory :book_suggestion do
    editorial { Faker::Book.publisher }
    price     { Faker::Commerce.price }
    author    { Faker::Book.author }
    title     { Faker::Book.title }
    link      { Faker::Internet.url }
    publisher { Faker::Book.publisher }
    year      { Faker::Number.between(1950, Time.zone.today.year) }
    user
  end
end
