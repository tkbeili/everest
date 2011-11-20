class GiftingsController < ApplicationController
  before_filter :require_login

  def new
    @employee = Employee.find(params[:id])
    @gift = @employee.company.gifts.new(:gifter_id => current_user.id, :giftee_id => @employee.id)   
  end
  
  def create
    if params[:gift_id]
      @gift = Gift.find(params[:gift_id])
    else
      @gift = Gift.new(params[:gift])  
    end
    
    @gift.company = Company.find(params[:company_id])
    @gift.gift_type = Gift::TYPES[params[:gift][:gift_type].to_sym][:name]
    @gift.value = Gift::TYPES[params[:gift][:gift_type].to_sym][:value]
    if @gift.save
      redirect_to new_company_gifting_url(:company_id => @gift.company, :id => @gift.giftee_id), :notice => "Gifting was successful!"
    else
      render :new, param => {:id => @gift.giftee.id}
    end
  end
  
  def share
    large_count = params[:gift][:large_count].to_i
    small_count = params[:gift][:small_count].to_i
    company = current_user.company
    if (large_count * Gift::TYPES[:large][:value] + small_count * Gift::TYPES[:small][:value]).to_f > company.budget
      flash.now[:error] = "Sorry not enough money to share that much"
      @employee = Employee.find(params[:gift][:employee_id])
      @gift = @employee.company.gifts.new(:gifter_id => current_user.id, :giftee_id => @employee.id)      
      render :new
    else
      large_count.times do
        Gift.create(:gifter_id => params[:employee_id],
                    :company_id => company.id,
                    :gift_type => Gift::TYPES[:large][:name],
                    :gift_type => Gift::TYPES[:large][:value])
      end
      
      small_count.times do
        Gift.create(:gifter_id => params[:employee_id],
                    :company_id => current_user.company.id,
                    :gift_type => Gift::TYPES[:large][:name],
                    :gift_type => Gift::TYPES[:large][:value])
      end
      
      redirect_to new_company_gifting_url(:company_id => company, :id => params[:gift][:employee_id])       
    end   
  end
  
end
