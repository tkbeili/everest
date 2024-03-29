 class Company < ActiveRecord::Base
  has_many :employees
  has_many :gifts
  
  validates :name,:domain, :presence => true, :uniqueness => true
  
  accepts_nested_attributes_for :employees, :allow_destroy => true
  
  def amount_spent
    left + invested + unspent
  end
  
  def invested
    invested = 0
    gifts.given.each {|gift| invested += gift.value}
    invested
  end
  
  def left
    budget
  end
  
  def unspent
    unspent = 0
    gifts.unspent.each {|gift| unspent += gift.value}
    unspent      
  end
  
 end
