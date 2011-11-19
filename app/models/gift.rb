class Gift < ActiveRecord::Base
  belongs_to :company
  TYPES = { :free => {:name => "Free", :value => 0}, 
            :small => {:name => "Small", :value => 10}, 
            :large => {:name => "Large", :value => 100}}
  
  
  scope :given, where("gifter_id IS NOT NULL AND giftee_id IS NOT NULL")
  
  def gifter
    Employee.find(gifter_id)
  end
  
 def giftee
    Employee.find(giftee_id)
  end  
end
