class Gift < ActiveRecord::Base
  belongs_to :company
  
  scope :given, where("gifter_id IS NOT NULL AND giftee_id IS NOT NULL")
end
