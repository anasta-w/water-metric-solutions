class Meter < ActiveRecord::Base
  belongs_to :farm_block
  has_many :alerts, as: :alertable
end
