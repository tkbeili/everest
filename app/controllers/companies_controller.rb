class CompaniesController < ApplicationController
  
  def new
    @company = Company.new
    @employee = Employee.new    
  end
  
  def create
    begin
      @employee = Employee.new(params[:company].delete(:employee))
      @employee.make_admin
      @company = company.new(params[:company])           
      ActiveRecord::Base.transaction do
        @company.save!
        @employee.company = @company
        @employee.save!   
      end
      logout
      session[:auto_login_employee_id] = @employee.id
      redirect_to root_url
    rescue ActiveRecord::RecordInvalid => invalid
       render :new
    end     
  end
  
  def invite
    
  end
end
