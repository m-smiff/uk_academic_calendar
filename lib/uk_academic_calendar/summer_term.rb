# frozen_string_literal: true

require_relative 'term'

module UKAcademicCalendar
  # Concrete class allowing instantiation of instances of an Summer term, for a given academic year
  class SummerTerm < Term
    # @return [Date] the Monday after Easter Sunday
    def nominal_start_date
      Easter.easter(academic_year + 1).next_day
    end

    # @return [Date] Aug 31st
    def nominal_end_date
      nominal_start_date.end_of_academic_year
    end
  end
end
