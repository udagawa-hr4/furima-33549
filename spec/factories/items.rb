FactoryBot.define do
  factory :item do
      name                 {'花火'}
      explanation          {'花火'}
      category_id          {1}
      condition_id         {1}
      postage_type_id      {1}
      prefecture_id        {1}
      preparation_day_id   {1}
      price                {123456}

      association :user

      after(:build) do |message|
        message.image.attach(io: File.open('public/images/2019100100055_1.jpg'), filename: '2019100100055_1.jpg')
      end


  end
end
