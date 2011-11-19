class GiftingsController < ApplicationController
  before_filter :require_login

  def new
    @employee = Employee.find(params[:id])
    @gift = @employee.company.gifts.new(:gifter_id => current_user.id, :giftee_id => @employee.id)   
  end
  
  def create
    @gift = Gift.new(params[:gift])
    @gift.company = Company.find(params[:company_id])
    @gift.gift_type = Gift::TYPES[params[:gift][:gift_type].to_sym][:name]
    @gift.value = Gift::TYPES[params[:gift][:gift_type].to_sym][:value]
    if @gift.save
      redirect_to new_company_gifting_url(:company_id => @gift.company, :id => @gift.giftee_id), :notice => "Gifting was successful!"
    else
      render :new, param => {:id => @gift.giftee.id}
    end
  end
end
