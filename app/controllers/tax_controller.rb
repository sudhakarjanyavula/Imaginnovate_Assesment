class TaxController < ApplicationController
    require 'tax_calculator'
  
    def deduction
      employees = Employee.all
      tax_deductions = employees.map { |employee| TaxCalculator.calculate_tax(employee) }
      render json: tax_deductions
    end
  end