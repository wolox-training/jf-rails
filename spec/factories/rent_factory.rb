FactoryBot.define do
  factory :rent do
    user
    book
    from { Faker::Date.between(2.days.ago, Time.zone.today) }
    to { Faker::Date.between(Time.zone.today, 10.days.from_now) }
  end
end
