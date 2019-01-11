class Slot < ApplicationRecord
  belongs_to :availability
  
  using Refinements
  DURATION_IN_MINUTES = 30.freeze

  # Localize a Coaches time slot, via the
  # Coaches time zone to a Students time
  # zone.
  #
  # Example:
  #
  #   Coaches time slot and time zone:
  #   "9:30AM Central Time (US & Canada)"
  #
  #   Students time zone:
  #   "Eastern Time (US & Canada)"
  #
  #   Local time for the Student via in_time_zone:
  #   "10:30AM"
  #
  # More info:
  #   https://apidock.com/rails/String/in_time_zone
  def localize(coach, student)
    localized = "#{self.start} #{coach.parse_time_zone}"
    localized.in_time_zone(student.parse_time_zone)
  end

  # Class methods
  class << self

    # Query all time Slots for the Availability ID's passed in.
    # Fixing N + 1 issues with this query.
    def all_with_availabilities(ids)
      self.includes(:availability).where('availability_id IN (?)', ids).references(:availability)
    end

    # Generates an Array of times, chunked into a duration of
    # minutes, based upon a start and finish time passed in.
    #
    # Example:
    #
    #   generate('9:00am', '11:00am')
    #   => %w(9:00am 9:30am 10:00am 10:30am)
    #
    #   Notice this was in 30 minute chunks based upon our
    #   DURATION_IN_MINUTES constant, and the last time passed
    #   in '11:00am' was not returned in the Array. If we start
    #   at 10:30am for 30 minutes, our finish time is 11:00am.
    #   Nothing available after 11:00am
    def generate(start, finish)

      start.remove_all_spaces!
      finish.remove_all_spaces!
      validate_times(start, finish)

      start = Time.parse(start)
      finish = Time.parse(finish)

      total = total_iterations(start, finish)

      slots = []
      1.upto(total) do
        slots << start.to_formatted_string
        start += (get_duration * 60)
      end
      slots
    end

    # Examples:
    #
    #   start time: 9:00
    #   finish time: 15:00 (24 hour clock)
    #
    #   DURATION_IN_MINUTES = 30
    #   60 / 30 = 2 (half hour)
    #   (15 - 9) * 2 = 12
    #   Doubling the number of iterations, giving us the ability to
    #   fill time slots every 30 minutes instead of 1 per hour.
    #
    #   DURATION_IN_MINUTES = 15
    #   60 / 15 = 4 (quarter hour)
    #   (15 - 9) * 4 = 24
    #   Quadrupling the number of iterations, giving us the ability
    #   to fill time slots every 15 minutes instead of 1 per hour.
    def total_iterations(start, finish)
      offset = (60.0 / get_duration.to_f).round
      (finish.hour - start.hour) * offset
    end

    # Get the duration and set a default duration
    # in-case someone goes over the 60 minutes max.
    def get_duration
      (DURATION_IN_MINUTES > 60) ? 60 : DURATION_IN_MINUTES
    end

    # String validation for proper Time format.
    def validate_times(*times)
      times.each do |time|
        raise ArgumentError unless match(time)
      end
    end

    # Regex a String for Time format.
    def match(time)
      time.match /^[0-9]{1,2}\:[0-9]{2}?[AP][M]/i
    end
  end

end
