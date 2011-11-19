class Company < ActiveRecord::Base
  has_many :users
  has_many :gifts
  
  validates :name,:domain, :presence => true, :uniqueness => true
end
