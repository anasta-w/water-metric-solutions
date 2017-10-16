class InflowMeter < ActiveRecord::Base
  belongs_to :farm_block
  has_one :location, as: :locationable
  has_many :alerts, as: :alertable

  def alert_attributes
    [
      ["Output", 1]
    ]
  end

  def get_inflow_data
    return rand(30..100)
  end

  validates_presence_of :calibration_unit
end
