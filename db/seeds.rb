# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# User seeds

# def create_users(number = 5)
#   number.times do
#     first = Faker::Name.first_name
#     last = Faker::Name.last_name
#     full_name = "#{first} #{last}"
#     User.create!(first_name: first,
#                 last_name: last,
#                 email: Faker::Internet.email(full_name),
#                 password: first,
#                 phone: Faker::PhoneNumber.phone_number)
#   end
# end
#
# create_users

# Create test account
# theo = User.create!(first_name: 'Theo',
#                 last_name: 'Paul',
#                 email: "theo@theinstillery.com",
#                 password: "opensesame123",
#                 phone: '0211149935'
#                 )

# mike = User.create!(first_name: "Mike",
#               last_name: "Jenkins",
#               email: "mike@theinstillery.com",
#               password: "mikeJenkins123",
#               phone: "0212265128"
#               )

# richie = User.create!(first_name: "Richie",
#               last_name: "Wildman",
#               email: "rjdwildman@gmail.com",
#               password: "w1lDman",
#               phone: "0211587239")

# scott = User.create!(first_name: "Scott",
#               last_name: "Townshend",
#               email: "hello@eltorito.co.nz",
#               password: "Sc0tt123",
#               phone: "0210566770")

# marcus = User.create!(first_name: "Marcus",
#               last_name: "Graham",
#               email: "mgraham1234@gmail.com",
#               password: "Marcus123",
#               phone:"123456789")

# jack = User.create!(first_name: "Jack",
#               last_name: "Downs",
#               email: "jack@theinstillery.com",
#               password: "JackDowns123",
#               phone: "02102679303")

# Create user has permision access in Losant
water = User.create!(first_name: "Water",
              last_name: "Metric",
              email: "watermetricsolutions@gmail.com",
              password: "WaterMetric2017",
              phone: "012345678")

# Farm Block seed

# def give_me_float
#   dp_length = rand(9)
#   output = rand(10 ** dp_length).to_f
#   return output / 10 ** dp_length
# end

# def generate_longitude
#   base = [rand(180), -rand(180)].sample
#   return base + give_me_float
# end

# def generate_latitude
#   base = [rand(90), -rand(90)].sample
#   return base + give_me_float
# end

def create_farm_block
  User.all.each do |user|
    FarmBlock.create!(name: "#{user.first_name}'s Farm",
                      user_id: user.id)
  end
end

create_farm_block

# FarmBlock.create!(name: "Longridge Farm",
                  # user_id: 1)
# Location.create!(address: "",longitude:174.777721, latitude:-36.853535, locationable_id: 6, locationable_type:"FarmBlock")


# Water Meters seed
water.farm_blocks.first.inflow_meters.create!(
  # height: 2.5,
  # capacity: 25000,
  name: "1C8E99-1",
  device_EUI: "590bc819d8f11a0001e6aad5",
  calibration_unit: 0,
  daily_consent: 0
)

water.farm_blocks.first.inflow_meters.create!(
  # height: 2.5,
  # capacity: 25000,
  name: "1C8E99-2",
  device_EUI: "590fe3dec2e38c0001dc78de",
  calibration_unit: 0,
  daily_consent: 0
)

# water.farm_blocks.first.inflow_meters.create!(
#   # height: 2.5,
#   # capacity: 25000,
#   name: "4D517B-1",
#   device_EUI: "59117f24c2e38c0001dc7949",
#   calibration_unit: 10,
#   daily_consent: 100
# )

# water.farm_blocks.first.inflow_meters.create!(
#   # height: 2.5,
#   # capacity: 25000,
#   name: "4D5185-1",
#   device_EUI: "59117c78c2e38c0001dc7948",
#   calibration_unit: 10,
#   daily_consent: 100
# )


# mike.farm_blocks.first.inflow_meters.create!(
# # height: 2.5,
# # capacity: 25000,
# name: "Mike's Inflow Meter",
# device_EUI: "00000000C1D10B7F",
# calibration_unit: 10,
# daily_consent: 100)

# richie.farm_blocks.first.inflow_meters.create!(
# # height: 2.5,
# # capacity: 25000,
# name: "Richie's Inflow Meter",
# device_EUI: "00000000C1D10B7F",
# calibration_unit: 10,
# daily_consent: 100)

# scott.farm_blocks.first.inflow_meters.create!(
# # height: 2.5,
# # capacity: 25000,
# name: "Scott's Inflow Meter",
# device_EUI: "00000000C1D10B7F",
# calibration_unit: 10,
# daily_consent: 100)

# marcus.farm_blocks.first.inflow_meters.create!(
# # height: 2.5,
# # capacity: 25000,
# name: "Marcus' Inflow Meter",
# device_EUI: "00000000C1D10B7F",
# calibration_unit: 10,
# daily_consent: 100)

# Create Water Tank
# WaterTank.create!(farm_block_id: 1,
#                   height: '0',
#                   capacity: '100',
#                   name: 'Flow Meter Knode',
#                   device_EUI: '5911a974c2e38c0001dc794b')


WaterTank.create!(farm_block_id: 1,
                  height: '0',
                  capacity: '100',
                  name: 'Tank Level Knode',
                  device_EUI: '59117c78c2e38c0001dc7948')

# Location seed

# def create_locations
#   FarmBlock.all.each do |fb|
#     Location.create!(longitude: generate_longitude,
#                      latitude: generate_latitude,
#                      locationable_id: fb.id,
#                      locationable_type: "FarmBlock")
#   end
#   WaterTank.all.each do |wt|
#     Location.create!(longitude: generate_longitude,
#                      latitude: generate_latitude,
#                      locationable_id: wt.id,
#                      locationable_type: "WaterTank")
#   end
# end

# create_locations

# Address seed

# def create_addresses
#   FarmBlock.all.each do |fb|
#     Address.create!(address_one: Faker::Address.street_address,
#                     address_two: Faker::Address.secondary_address,
#                     state: Faker::Address.state,
#                     city: Faker::Address.city,
#                     post_code: Faker::Address.postcode,
#                     farm_block_id: fb.id)
#   end
# end

# create_addresses

# Meter Seed

# Meter.create!(name: "Meter 1C8E99-1",
#               type: "Inflow",
#               farm_block_id: 1)
