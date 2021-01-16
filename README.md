# README

# users


| Column               | Type       | Option                           |
|----------------------|------------|----------------------------------|
|nickname              |string      |null:false                        |
|email                 |string      |null:false,index: { unique: true }|
|encrypted_password    |string      |null:false                        |
|first_name            |string      |null:false                        |
|family_name           |string      |null:false                        |
|read_first            |string      |null:false                        |
|read_family           |string      |null:false                        |
|birthday              |date        |null:false                        |


### Association

-has_many :items
-has_many :purchases

## items

| Column               | TYpe       | Option                     |
|----------------------|------------|----------------------------|
|name                  |string      |null:false                  |
|explanation           |text        |null:false                  |
|category_id           |integer     |null:false                  | 
|condition_id          |integer     |null:false                  |
|postage_type_id       |integer     |null:false                  |
|prefecture_id         |integer     |null:false                  |
|preparation_day_id    |integer     |null:false                  |
|price                 |integer     |null:false                  |
|user                  |references  |null:false,foreign_key: true|


### Association

-has_one :purchase_info
-belongs_to :user

## purchases

| Column               | Type       | Option                     |
|----------------------|------------|----------------------------|
|user                  |references  |null:false,foreign_key: true|
|item                  |references  |null:false,foreign_key: true|

### Association
-has_one :shopping_address
-belongs_to :item
-belongs_to :user

## shopping_address

| Column               | Type       | Option                     |
|----------------------|------------|----------------------------|
|postal_code           |string      |null:false                  |
|prefecture_id        |integer     |null:false                  |
|city                  |string      |null:false                  |
|address               |string      |null:false                  |
|building_name         |string      |                            |
|phone_number          |string      |null:false                  |
|purchase              |references  |null:false,foreign_key: true|

### Association
belongs_to :purchase