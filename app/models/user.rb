class User < ApplicationRecord
  has_many :availabilities

  # Time zones are in the format:
  #   (GMT-06:00) Central Time (US & Canada)
  #   (GMT-09:00) America/Yakutat
  #
  # To work with then via Ruby core libs we need
  # the '(GMT-09:00) ' part parsed out of it.
  def parse_time_zone
    self.time_zone.gsub(/\(GMT.*?\)\s/, '')
  end
end
