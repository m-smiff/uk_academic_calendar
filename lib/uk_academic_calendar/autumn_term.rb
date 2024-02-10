# frozen_string_literal: true

require_relative 'term'

module UKAcademicCalendar
  # Concrete class allowing instantiation of instances of an Autumn term, for a given academic year
  class AutumnTerm < Term
    # @return [Date] Sep 1st
    def nominal_start_date
      @nominal_start_date ||= Date.today.beginning_of_academic_year.change(year: academic_year)
    end

    # @return [Date] Dec 31st
    def nominal_end_date
      @nominal_end_date ||= nominal_start_date.end_of_year
    end
  end
end
