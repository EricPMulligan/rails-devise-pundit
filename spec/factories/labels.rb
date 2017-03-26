FactoryGirl.define do
  factory(:label) do
    association(:user)
    name { Faker::Name.name }
    colour { Faker::Color.color_name }
  end
end