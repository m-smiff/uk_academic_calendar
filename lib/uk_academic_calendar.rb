# frozen_string_literal: true

require 'uk_academic_calendar/version'

require 'uk_academic_calendar/core_ext/date'
require 'uk_academic_calendar/core_ext/time'
require 'uk_academic_calendar/core_ext/integer'
require 'uk_academic_calendar/autumn_term'
require 'uk_academic_calendar/spring_term'
require 'uk_academic_calendar/summer_term'

require 'active_support/core_ext/class/subclasses'
require 'active_support/core_ext/object/inclusion'

# Top-level namespace, itself implementing a number of constants and module methods documented below.
module UKAcademicCalendar
  # The month-number corresponding to the first month within the calendar year that the academic year starts in.
  YEAR_OFFSET_START_MONTH = 9 # September
  # The season-names designating the 3 terms.
  SEASONS = [:autumn, :spring, :summer].freeze

  class << self
    # @!method autumn_term
    # @param academic_year [Integer] the calendar year the academic year starts in.
    # @return [UKAcademicCalendar::AutumnTerm] instance of Autumn term.

    # @!method spring_term
    # @param academic_year [Integer] the calendar year the academic year starts in.
    # @return [UKAcademicCalendar::SpringTerm] instance of Spring term.

    # @!method summer_term
    # @param academic_year [Integer] the calendar year the academic year starts in.
    # @return [UKAcademicCalendar::SummerTerm] instance of Summer term.
    SEASONS.each do |season|
      define_method(:"#{season}_term") do |academic_year|
        klass = Term.descendants.find { |c| c.to_s.demodulize.downcase.start_with? season.to_s }
        klass.new(academic_year)
      end
    end

    # @param academic_year [Integer] the calendar year the academic year starts in.
    # @return [Array(UKAcademicCalendar::AutumnTerm, UKAcademicCalendar::SpringTerm, UKAcademicCalendar::SummerTerm)]
    #   array containing ordered instances of Autumn, Spring and Summer term.
    def all_terms(academic_year)
      SEASONS.map { |term_name| public_send(:"#{term_name}_term", academic_year) }
    end

    # Convenience method for retrieving the term object including Date.today
    # @return [UKAcademicCalendar::AutumnTerm, UKAcademicCalendar::SpringTerm, UKAcademicCalendar::SummerTerm] instance
    #   of Autumn/Spring/Summer term deemed to contain today's date.
    def term_now
      term_including
    end

    # @param val [#to_date]
    # @return [UKAcademicCalendar::AutumnTerm, UKAcademicCalendar::SpringTerm, UKAcademicCalendar::SummerTerm] instance
    #   of Autumn/Spring/Summer term deemed to contain date param.
    def term_including(val = Date.today)
      date = val.to_date
      all_terms(date.academic_year).find { |term| date.in? term }
    end
  end
end
