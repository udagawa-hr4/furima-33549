FactoryBot.define do
  factory :purchase_shopping do
    token                 { "tok_abcdefghijk00000000000000000" }
    postal_code                 { "123-1234" }
    prefecture_id             { 1 }
    city                  {"市川市" }
    address               { '高谷１−２−３' }
    building_name         { 'ハイツ102号室' }
    phone_number            { "09012345678" }
  end
end