class Gift < ActiveRecord::Base
  belongs_to :company
  TYPES = { :free => {:name => "free", :value => 0}, 
            :small => {:name => "small", :value => 10}, 
            :large => {:name => "large", :value => 100}}
  
  attr_accessor :small_count, :large_count
  attr_accessible :small_count, :large_count, :giftee_id, :gifter_id, :gift_type, :message
  
  validates :gift_type, :value, :gifter_id, :company_id, :presence => true
  
  scope :given, where("gifter_id IS NOT NULL AND giftee_id IS NOT NULL")
  scope :unspent, where("gifter_id IS NOT NULL AND giftee_id IS  NULL")
  
  def gifter
    Employee.find(gifter_id)
  end
  
  def giftee
    Employee.find(giftee_id)
  end  
  
end
