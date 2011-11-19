class Employee < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :company
  
  validates :email, :presence => true
end
