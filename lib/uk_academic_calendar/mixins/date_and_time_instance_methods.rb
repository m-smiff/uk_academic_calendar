# frozen_string_literal: true

module UKAcademicCalendar
  # Mixin included in Date and Time classes providing academic year related instance methods
  module DateAndTimeInstanceMethods
    # @return [Integer] integer representing the calendar year within the academic year started in
    # @example
    #   Date.new(2024, 8, 31).academic_year #=> 2023
    #   Time.new(2024, 9, 1, 12).academic_year #=> 2024
    def academic_year
      return year if yday >= start_yday

      year - 1
    end

    # @return [#to_date] instance of self.class representing the beginning of the academic year
    # @example
    #   Date.new(2024, 8, 31).beginning_of_academic_year #=> 2023-09-01
    #   Time.new(2024, 9, 1, 12).beginning_of_academic_year #=> 2024-09-01 00:00:00 +0100
    def beginning_of_academic_year
      shifted = change(year: academic_year, month: YEAR_OFFSET_START_MONTH, day: 1)
      return shifted unless acts_like? :time

      shifted.beginning_of_day
    end

    # @return [#to_date] instance of self.class representing the end of the academic year
    # @example
    #   Date.new(2024, 8, 31).end_of_academic_year #=> 2024-08-31
    #   Time.new(2024, 9, 1, 12).end_of_academic_year #=> 2025-08-31 23:59:59.999999999 +0100
    def end_of_academic_year
      shifted = beginning_of_academic_year.next_year.prev_day
      return shifted unless acts_like? :time

      shifted.end_of_day
    end

    # @return [Integer] integer representing the month of the academic year including self
    # @example
    #   Date.new(2024, 8, 31).academic_year_month #=> 12
    #   Time.new(2024, 11, 1, 12).academic_year_month #=> 3
    def academic_year_month
      ac_yr_start_month = YEAR_OFFSET_START_MONTH
      ((month - ac_yr_start_month) % 12) + 1
    end

    # @return [UKAcademicCalendar::AutumnTerm, UKAcademicCalendar::SpringTerm, UKAcademicCalendar::SummerTerm]
    #   term object including self
    # @example
    #   Date.new(2024, 8, 31).academic_term #=> Summer 2023/2024
    #   Time.new(2024, 11, 1, 12).academic_term #=> Autumn 2024/2025
    def academic_term
      UKAcademicCalendar.term_including self
    end

    # @return [#to_date] instance of self.class representing the beginning of the academic term including self
    # @example
    #   Date.new(2024, 2, 25).beginning_of_academic_term #=> 2024-01-01
    #   Time.new(2024, 9, 1, 12).beginning_of_academic_term #=> 2024-09-01 00:00:00 +0100
    def beginning_of_academic_term
      term_start = academic_term.start_date
      shifted = change(year: term_start.year, month: term_start.month, day: term_start.day)
      return shifted unless acts_like? :time

      shifted.beginning_of_day
    end

    # @return [#to_date] instance of self.class representing the end of the academic term including self
    # @example
    #   Date.new(2024, 11, 25).end_of_academic_term #=> 2024-12-31
    #   Time.new(2024, 7, 1, 12).end_of_academic_term #=> 2024-08-31 23:59:999999999 +0100
    def end_of_academic_term
      term_end = academic_term.end_date
      shifted = change(year: term_end.year, month: term_end.month, day: term_end.day)
      return shifted unless acts_like? :time

      shifted.end_of_day
    end

    private

    def start_yday
      self.class.new(year, YEAR_OFFSET_START_MONTH, 1).yday
    end
  end
end
