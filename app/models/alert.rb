class Alert < ActiveRecord::Base
  belongs_to :water_tank
  belongs_to :inflow_meter
  belongs_to :alertable, polymorphic: true


  def actions
    [
      ["Text", 1],
      ["Email", 2],
      ["Red Pin Alert", 3],
      ["Amber Pin Alert", 4],
      ["Web Notification", 5],
      ["App Notification", 6]
    ]
  end

  def conditions
    [
      ["IS LESS THAN", "lessThan"],
      ["IS GREATER THAN", "greaterThan"],
    ]
  end

end
