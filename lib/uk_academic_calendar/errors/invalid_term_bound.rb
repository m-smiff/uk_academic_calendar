# frozen_string_literal: true

require_relative 'error'

module UKAcademicCalendar
  # Error class raised when a concrete term class is deemed to have an invalid date-bound
  class InvalidTermBound < Error
    def initialize(date, comparand)
      @date = date
      @comparand = comparand
      super(message)
    end

    # @return [String]
    def message
      "#{@date} is invalid. Must be #{comparison_qualifier} #{@comparand}"
    end

    private

    def comparison_qualifier
      @comparand.instance_of?(Range) && 'within'
    end
  end
end
