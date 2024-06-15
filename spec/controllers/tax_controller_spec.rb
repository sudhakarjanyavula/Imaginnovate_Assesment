require 'rails_helper'

RSpec.describe TaxController, type: :controller do
  describe 'GET #deduction' do
    let(:employee1) { create(:employee, employee_code: 'E123', first_name: 'John', last_name: 'Doe', doj: Date.new(2023, 1, 1), salary: 50000, email: "example@yopmail.com", phone_number: ['9999999999', '8888888888']) }
    let(:employee2) { create(:employee, employee_code: 'E124', first_name: 'Jane', last_name: 'Doe', doj: Date.new(2023, 5, 1), salary: 60000, email: "example1@yopmail.com", phone_number: ['7777777777', '6666666666']) }
    
    before do
      allow(Employee).to receive(:all).and_return([employee1, employee2])
      get :deduction
    end

    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct tax deductions for all employees' do
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(2)

      expect(json_response[0]['employee_code']).to eq('E123')
      expect(json_response[1]['yearly_salary']).to be_within(0.01).of(720000.0)
      expect(json_response[0]['tax_amount']).to eq(27500.0)
      expect(json_response[0]['cess_amount']).to eq(0)

      expect(json_response[1]['employee_code']).to eq('E124')
      expect(json_response[1]['yearly_salary']).to be_within(0.01).of(720000.0)
      expect(json_response[1]['tax_amount']).to eq(34500.0)
      expect(json_response[1]['cess_amount']).to eq(0)
    end
  end
end
