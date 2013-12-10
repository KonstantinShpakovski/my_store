FactoryGirl.define do
  factory :user do
    #login "login"
    sequence(:email) { |i| "email#{1}@email.com"}
    password "password"
  end
end