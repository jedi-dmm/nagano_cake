# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create!(
                  customer_status: "true",
                  last_name: "麻生",
                  first_name: "太郎",
                  last_name_kana: "アソウ",
                  first_name_kana: "タロウ",
                  tel: "00000000000",
                  email: "test@test.jp",
                  password: "password",
                  postcode: "0000000",
                  address: "東京都  歌舞伎町3丁目",
                  )

Customer.create!(
                  customer_status: "false",
                  last_name: "阿部",
                  first_name: "心臓",
                  last_name_kana: "アベ",
                  first_name_kana: "シンゾウ",
                  tel: "00000000001",
                  email: "aa@test.jp",
                  password: "password",
                  postcode: "0000001",
                  address: "東京都  歌舞伎町1丁目",
                  )

Admin.create!(
                  email: "aaddmmiinn@test.jp",
                  password: "password",
                  )