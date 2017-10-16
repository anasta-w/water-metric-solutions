class WaterTank < ActiveRecord::Base
  belongs_to :farm_block
  has_one :location, as: :locationable
  has_many :alerts, as: :alertable

  def alert_attributes
    return [
      ["Volume", 1]
    ]
  end
end
