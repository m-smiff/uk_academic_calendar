# frozen_string_literal: true

require_relative '../mixins/succ_slashable'

class Integer
  # prepends "UKAcademicCalendar::SuccSlashable"
  # @!parse prepend UKAcademicCalendar::SuccSlashable
  prepend UKAcademicCalendar::SuccSlashable
end
