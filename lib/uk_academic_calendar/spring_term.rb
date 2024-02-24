# frozen_string_literal: true

require_relative 'term'

module UKAcademicCalendar
  # Concrete class allowing instantiation of instances of a spring term, for a given academic year
  class SpringTerm < Term
    # @return [Date] Jan 1st
    def nominal_start_date
      nominal_end_date.beginning_of_year
    end

    # @return [Date] Easter Sunday
    def nominal_end_date
      Easter.easter(academic_year + 1)
    end
  end
end
