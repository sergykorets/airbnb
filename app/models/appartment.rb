class Appartment < ApplicationRecord
  geocoded_by :address #can also be an IP address
  before_validation :geocode, :if => :address_changed?

  belongs_to :author

  validates_uniqueness_of :longitude, scope: :latitude

  validates_presence_of :rent
  validates_presence_of :address
end