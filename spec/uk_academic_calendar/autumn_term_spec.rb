# frozen_string_literal: true

RSpec.describe UKAcademicCalendar::AutumnTerm do
  let(:assert_season) { :autumn }
  let(:assert_nominal_start_date) { Date.new(academic_year, 9, 1) }
  let(:assert_nominal_end_date) { Date.new(academic_year, 12, 31) }

  include_examples 'concrete term class'
end
