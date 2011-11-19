class InvitationsController < ApplicationController
  before_filter :require_login
  
  def new
    @company = Company.find(params[:company_id]) 
    3.times do
      @company.employees.build
    end
  end  
  
  
  def create
    @company = Company.find(params[:company_id])
    if @company.update_attributes(params[:company])
      flash[:notice] = "Successfully updated survey."
      redirect_to company_path(@company)
    else
      render :action => 'new'
    end
  end
  
end
