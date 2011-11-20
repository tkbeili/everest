class CompaniesController < ApplicationController
  before_filter :require_login, :only => [:index]
  
  def index        
  end
  
  def show
    @company = current_user.company
    @employees = @company.employees
    @gifts = @company.gifts.given.limit(50)
  end
  
  def new
    @company = Company.new
    @employee = Employee.new    
  end
  
  def create
    begin
      @employee = Employee.new(params[:company].delete(:employee))
      @employee.is_admin = true
      @company = Company.new(params[:company])
      @company.budget = 1000.00           
      ActiveRecord::Base.transaction do
        @company.save!
        @employee.company = @company        
        @employee.save!   
      end
      auto_login(@employee)
      session[:employee_id] = @employee.id
      redirect_to new_company_invitation_path(@company.id)
    rescue ActiveRecord::RecordInvalid => invalid
       render :new
    end     
  end
  
  def invite
    
  end
end
