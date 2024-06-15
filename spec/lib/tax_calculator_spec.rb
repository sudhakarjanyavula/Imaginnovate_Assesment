require 'rails_helper'
require 'tax_calculator'

RSpec.describe TaxCalculator do
  let(:employee) { double('Employee', employee_code: 'E123', first_name: 'John', last_name: 'Doe', doj: doj, salary: salary, email: "example@yopmail.com", phone_number: ["9999999999", "8888888888"]) }
  let(:doj) { Date.new(2023, 1, 1) }
  let(:salary) { 50000 }

  describe '.calculate_tax' do
    subject { described_class.calculate_tax(employee) }

    context 'when employee has been working for the entire period' do
      it 'calculates the correct tax and cess amount' do
        result = subject
        expect(result[:yearly_salary]).to be_within(0.01).of(650000) 
        expect(result[:tax_amount]).to eq(27500) 
        expect(result[:cess_amount]).to eq(0) 
      end
    end

    context 'when employee joined after the start date' do
      let(:doj) { Date.new(2023, 5, 15) }
      it 'calculates the prorated salary, tax, and cess amount' do
        result = subject
        expect(result[:yearly_salary]).to be_within(0.01).of(527419.3548387097)
        expect(result[:tax_amount]).to eq(15241.93548387097) 
        expect(result[:cess_amount]).to eq(0) 
      end
    end

    context 'when employee has a high salary' do
      let(:salary) { 300000 }
      it 'calculates the correct tax and includes cess amount' do
        result = subject
        expect(result[:yearly_salary]).to be_within(0.01).of(3900000) 
        expect(result[:tax_amount]).to eq(642500) 
        expect(result[:cess_amount]).to eq(78000) 
      end
    end
  end
end
