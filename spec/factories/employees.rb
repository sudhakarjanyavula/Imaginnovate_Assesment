# spec/factories/employees.rb
FactoryBot.define do
    factory :employee do
      sequence(:employee_code) { |n| "E#{n}" }
      first_name { 'John' }
      last_name { 'Doe' }
      doj { Date.new(2023, 1, 1) }
      salary { 50000 }
      email { 'example@yopmail.com' }
      phone_number { ['9999999999', '8888888888'] } 
    end
  end
  