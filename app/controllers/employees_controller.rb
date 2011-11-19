class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
  end
  
  def create
    @employee = employee.new(params[:employee])
    email = @employee.email
    @company = Company.find_by_domain(email[email.index("@")+1..email.length])
    if @company.nil?
      flash.now[:notice]= "Your email domain doesn't seem to be associated with a company. Sign up your company if it isn't"
      render :new
    else
      @employee.company = @company
      if @employee.save
        auto_login(@employee)
        redirect_to root_url, :notice => "Sign Up Success"
      else
        render :new
      end      
    end
  end

end
