class EmployeesController < ApplicationController
  def index
    @company = current_user.company
    @employees = @company.employees    
  end
  
  def new
    @employee = Employee.new
  end
  
  def edit
    @employee = current_user    
  end
  
  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      redirect_to company_url(@employee.company), :notice => "Account updated successfully!"
    else  
      render :edit
    end
  end
  
  def create
    @employee = Employee.new(params[:employee])
    email = @employee.email
    @company = Company.find_by_domain(email[email.index("@")+1..email.length])
    if @company.nil?
      flash.now[:notice]= "Your email domain doesn't seem to be associated with a company. Sign up your company if it isn't"
      render :new
    else
      @employee.company = @company
      invited_employee = Employee.where(:email => @employee.email, :crypted_password => nil)
      if invited_employee        
        if @employee.update_attributes(params[:employee])
          auto_login(@employee)
          redirect_to company_url(@employee.company.id), :notice => "Sign Up Success"
        else
          render :new
        end        
      else 
        if @employee.save
          auto_login(@employee)
          redirect_to company_url(@employee.company.id), :notice => "Sign Up Success"
        else
          render :new
        end 
      end     
    end
  end

end
