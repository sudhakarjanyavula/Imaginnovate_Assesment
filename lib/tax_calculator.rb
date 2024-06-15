module TaxCalculator
    def self.calculate_tax(employee)
      start_date = Date.new(Date.today.year - 1, 3, 1)
      end_date = Date.new(Date.today.year, 4, 1)
  
      start_date = employee.doj if employee.doj > start_date
      months_worked = ((end_date.year * 12 + end_date.month) - (start_date.year * 12 + start_date.month)).to_f
      months_worked -= 1 if end_date.day < start_date.day
  
      if employee.doj.month == start_date.month && employee.doj.year == start_date.year
        days_worked = (Date.new(start_date.year, start_date.month, -1).day - start_date.day + 1).to_f / Date.new(start_date.year, start_date.month, -1).day
        months_worked += days_worked
      end
  
      total_salary = employee.salary * months_worked
  
      tax_amount = case total_salary
                   when 0..250000
                     0
                   when 250001..500000
                     (total_salary - 250000) * 0.05
                   when 500001..1000000
                     12500 + (total_salary - 500000) * 0.1
                   else
                     62500 + (total_salary - 1000000) * 0.2
                   end 
      cess_amount = (total_salary * 0.02) if total_salary > 2500000
  
      {
        employee_code: employee.employee_code,
        first_name: employee.first_name,
        last_name: employee.last_name,
        yearly_salary: total_salary,
        tax_amount: tax_amount,
        cess_amount: cess_amount || 0
      }
    end
  end
  