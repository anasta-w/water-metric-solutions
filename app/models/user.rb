class User < ActiveRecord::Base

  # before_create :confirmation_token
  before_create {generate_token(:auth_token)}

  has_secure_password

  has_many :farm_blocks
  has_many :inflow_meters, through: :farm_blocks
  has_many :water_tanks, through: :farm_blocks

  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates_uniqueness_of :email

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  # def email_activate
  #   self.email_confirmed = true
  #   self.confirm_token = nil
  #   save!(:validate => false)
  # end
  #
  # private
  #
  # def confirmation_token
  #   if self.confirm_token.blank?
  #     self.confirm_token = SecureRandom.urlsafe_base64.to_s
  #   end
  # end
end
