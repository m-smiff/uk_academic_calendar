# frozen_string_literal: true

require 'abstract_class'
require 'easter'
require 'forwardable'
require 'sorted_set'

require_relative 'errors/invalid_term_start'
require_relative 'errors/invalid_term_end'

module UKAcademicCalendar
  # Abstract class representing blueprint behaviour for academic terms, bounded by writeable start and end dates
  class Term
    extend AbstractClass

    extend Forwardable
    # @!method include?
    #   Forwards to Range
    #   @see Range#include?
    # @!method each
    #   Forwards to Range
    #   @see Range#each
    def_delegators :to_range, :include?, :each

    # @param academic_year [Integer]
    # @return [UKAcademicCalendar::AutumnTerm, UKAcademicCalendar::SpringTerm, UKAcademicCalendar::SummerTerm]
    def initialize(academic_year)
      @academic_year = academic_year
      @season = extract_season_from_class_name
      @start_date = nominal_start_date
      @end_date = nominal_end_date
    end

    # @return [Integer] the calendar year within which the term's academic year starts in
    attr_reader :academic_year
    # @overload start_date
    # @overload start_date=(value)
    # Sets value to @start_date, first going through validation
    # @param val [#to_date, nil] the start date of the term. If nil given, falls back to #nominal_start_date
    # @return [Date] assigned date value
    # @raise [UKAcademicCalendar::InvalidTermStart, UKAcademicCalendar::InvalidTermEnd] if the assigned date is
    #   considered invalid
    attr_accessor :start_date
    # @overload end_date
    # @overload end_date=(value)
    # Sets value to @end_date, first going through validation
    # @param val [#to_date, nil] the end date of the term. If nil given, falls back to #nominal_end_date
    # @return [Date] assigned date value
    # @raise [UKAcademicCalendar::InvalidTermStart, UKAcademicCalendar::InvalidTermEnd] if the assigned date is
    #   considered invalid
    attr_accessor :end_date
    # @return [Symbol] the name of the season the term spans
    attr_reader :season

    # @return [Integer] the integer hash value for self
    def hash
      [self.class, academic_year, start_date, end_date].hash
    end

    # @param other [#hash] any object that responds to `#hash`
    # @return [Boolean] true if self and other are of the same class, academic_year, and have eql start and end dates.
    #   Otherwise returns false.
    def eql?(other)
      hash == other.hash
    end
    alias == eql?

    # @return [String] prettified string describing the term, e.g. "Summer 2023/2024"
    # @example
    #   term = UKAcademicCalendar::SummerTerm 2023
    #   term.to_s #=> "Summer 2023/2024"
    def to_s
      "#{season.to_s.titleize} #{academic_year.to_s(slash_succ: true)}"
    end

    def inspect
      to_s
    end

    def start_date=(val) # rubocop:disable Lint/DuplicateMethods
      @start_date = validate_date(val&.to_date, :start)
    end

    def end_date=(val) # rubocop:disable Lint/DuplicateMethods
      @end_date = validate_date(val&.to_date, :end)
    end

    # @return [Range] range bounded by start and end dates, end inclusive
    def to_range
      start_date..end_date
    end

    # @return [SortedSet<Date>] sorted set of dates making up the term
    def all_dates
      SortedSet.new(to_range.to_a)
    end

    private

    def extract_season_from_class_name
      self.class.to_s.demodulize[/(.*)Term\z/, 1].downcase.to_sym
    end

    def validate_date(date, bound)
      return public_send(:"nominal_#{bound}_date") unless date.present?

      # First validate the date is within bounds...
      validate_within_bounds(date, nominal_start_date..nominal_end_date, bound)
      # ...then validate the dates are in acceptable (i.e. start < end) sequence
      validate_sequence(date, bound)

      date
    end

    def validate_within_bounds(date, range, date_bound)
      return if date.in? range

      raise date_error_class(date_bound).new(date, range)
    end

    def validate_sequence(date, date_bound)
      operator, comparand = date_bound == :start ? [:<, :end_date] : [:>, :start_date]
      # Assuming this is for :start_date, return if #start_date == nil OR date < #end_date
      return if send(comparand).nil? || date.send(operator, send(comparand))

      raise date_error_class(date_bound).new(date, send(comparand))
    end

    def date_error_class(date_bound)
      case date_bound
      when :start then InvalidTermStart
      when :end then InvalidTermEnd
      end
    end
  end
end
