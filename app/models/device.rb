class Device < ActiveRecord::Base

  # before_create :confirmation_token
  before_create {generate_token(:auth_token)}

  has_secure_password

  has_many :farm_blocks
  has_many :inflow_meters, through: :farm_blocks
  has_many :water_tanks, through: :farm_blocks

  validates_presence_of :name, :description
  validates_uniqueness_of :email

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end #while User.exists?(column => self[column])
  end


end
