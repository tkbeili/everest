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
      @company = Company.find(params[:company_id])
      @company.budget -= Gift::TYPES[params[:gift][:gift_type].to_sym][:value]      
    end
    
       
    @gift.company = Company.find(params[:company_id])
    @gift.gift_type = Gift::TYPES[params[:gift][:gift_type].to_sym][:name]
    @gift.value = Gift::TYPES[params[:gift][:gift_type].to_sym][:value]
    if @gift.save            
      @company.save if @company
      redirect_to new_company_gifting_url(:company_id => @gift.company, :id => @gift.giftee_id), :notice => "Gifting was successful!"
    else
      render :new, params => {:id => @gift.giftee.id}
    end
  end
  
  def share
    large_count = params[:gift][:large_count].to_i
    small_count = params[:gift][:small_count].to_i
    company = current_user.company
    
    large_sum = large_count * Gift::TYPES[:large][:value]
    small_sum = small_count * Gift::TYPES[:small][:value]
    total_amount = large_sum + small_sum
    
    if total_amount.to_f > company.budget
      flash.now[:error] = "Sorry not enough money to share that much"
      @employee = Employee.find(params[:gift][:employee_id])
      @gift = @employee.company.gifts.new(:gifter_id => @employee.id)      
      render :new
    else
      large_count.times do
        Rails.logger.info ">>>>>>>>>>> XXXXXx"
        @gift = Gift.new( :gifter_id => params[:gift][:employee_id],
                          :gift_type => Gift::TYPES[:large][:name])
       @gift.company_id = company.id                          
       @gift.value = Gift::TYPES[:large][:value]
       @gift.save
       Rails.logger.info @gift.errors.inspect             
      end
      
      small_count.times do
        Rails.logger.info ">>>>>>>>>>>YYYYYYY"
        @gift = Gift.new( :gifter_id => params[:gift][:employee_id],   
                          :gift_type => Gift::TYPES[:large][:name])
        @gift.company_id = current_user.company.id
        @gift.value = Gift::TYPES[:large][:value]                  
        @gift.save
        Rails.logger.info @gift.errors.inspect                  
      end
      company.budget -= total_amount
      company.save  
      
      redirect_to new_company_gifting_url(:company_id => company, :id => params[:gift][:employee_id]), :notice => "Gifts shared successfully"       
    end   
  end
  
end
