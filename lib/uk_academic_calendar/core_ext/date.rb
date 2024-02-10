# frozen_string_literal: true

require 'active_support/core_ext/date'
require_relative '../mixins/date_and_time_instance_methods'

class Date
  # includes "UKAcademicCalendar::DateAndTimeInstanceMethods"
  # @!parse include UKAcademicCalendar::DateAndTimeInstanceMethods
  include UKAcademicCalendar::DateAndTimeInstanceMethods
end
