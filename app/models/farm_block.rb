class FarmBlock < ActiveRecord::Base

  before_save :default_name

  belongs_to :user
  has_one :location, as: :locationable
  has_one :address, as: :addressable
  has_many :water_tanks
  has_many :inflow_meters

  def has_water_tanks?
    if self.water_tanks.empty?
      return false
    else
      return true
    end
  end

  def has_inflow_meters?
    if self.inflow_meters.empty?
      return false
    else
      return true
    end
  end

  private

  def default_name
    if self.name == ""
      self.name = "Farm Block"
    end
  end
end
