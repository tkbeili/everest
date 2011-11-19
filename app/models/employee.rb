class Employee < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :company
  attr_accessor :password_confirmation
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  
  validates :password, :password_confirmation, :presence => true, :length => {:minimum => 4, :maximum => 16}, :on => :create  
  validates :email, :presence => true
end
