FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number:6)}
    email                 {Faker::Internet.free_email}
    password              {"abc123"}
    password_confirmation {password}
    family_name           {"山田"}
    read_family           {"ヤマダ"}
    first_name            {"太郎"}
    read_first            {"タロウ"}
    birthday              {"2000-01-01"}
  end
end