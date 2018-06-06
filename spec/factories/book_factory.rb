FactoryBot.define do
  factory :book do
    genre     { Faker::Book.genre }
    author    { Faker::Book.author }
    image     { Faker::Avatar.image }
    title     { Faker::Book.title }
    publisher { Faker::Book.publisher }
    year      { Faker::Number.between(1950, Time.zone.today.year) }
  end

  trait :rented do
    after(:create) do |book|
      create(:rent, book: book)
    end
  end
end
