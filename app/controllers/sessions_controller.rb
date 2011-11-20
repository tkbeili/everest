class SessionsController < ApplicationController
  def new
  end
  
  def create
    user_params = params[:employee]
    user = login(user_params[:email], user_params[:password], user_params [:remember_me])
    Rails.logger.info ">>>>>>>>"
    Rails.logger.info user
    Rails.logger.info ">>>>>>>>"
    if user
      redirect_back_or_to company_url(user.company.id), :notice => t("sessions.new.success")
    else
      flash.now[:alert] = t("sessions.new.failure")
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

end
