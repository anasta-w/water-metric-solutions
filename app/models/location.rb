class Location < ActiveRecord::Base

  belongs_to :farm_block
  belongs_to :water_tank
  belongs_to :inflow_meter
  belongs_to :locationable, polymorphic: true
end
