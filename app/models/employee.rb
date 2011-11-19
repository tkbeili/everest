class Employee < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :company
  attr_accessor :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  
  validates :password, :password_confirmation, :presence => true, :length => {:minimum => 4, :maximum => 16}, :on => :create  
  validates :email, :presence => true
  
  def full_name
    full_name = full_name_no_email
    full_name = email if full_name.strip.blank?
    full_name.strip
  end
  
  def full_name_no_email
    full_name = ""
    full_name += first_name + " " if first_name
    full_name += last_name if last_name
    full_name    
  end
  
  def gifts_received
    Gift.where(:giftee_id => id)
  end
  
  def gifts_given
    Gift.where(:gifter_id => id)
  end
  
  def gravatar_url(root_url)
    default_url = "#{root_url}assets/guest.png"
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
  end  
  
  def available_gifts(type)
    Gift.where(:gifter_id => id, :giftee_id => nil, :gift_type => type)
  end
  
end
