# frozen_string_literal: true

require_relative 'invalid_term_bound'

module UKAcademicCalendar
  # @see InvalidTermBound
  class InvalidTermStart < InvalidTermBound
    private

    def comparison_qualifier
      super || '<'
    end
  end
end
