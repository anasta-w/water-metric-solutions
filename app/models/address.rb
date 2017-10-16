class Address < ActiveRecord::Base

  belongs_to :farm_block

  validates_presence_of :address_one,
                        :address_two,
                        :state,
                        :city,
                        :post_code
end
