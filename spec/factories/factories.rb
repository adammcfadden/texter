FactoryGirl.define do
  factory :message do
    from "6149168051"
    body "Factory Girl Tes(x)t Message"

    after(:build) { |message| message.to_numbers.push(create(:to_number))}
  end

  factory :to_number do
    number "5035129206"
  end
end
