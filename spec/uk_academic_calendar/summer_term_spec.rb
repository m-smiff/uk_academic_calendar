# frozen_string_literal: true

RSpec.describe UKAcademicCalendar::SummerTerm do
  let(:assert_season) { :summer }
  let(:assert_nominal_start_date) { Easter.easter(academic_year + 1).next_day }
  let(:assert_nominal_end_date) { Date.new(academic_year + 1, 8, 31) }

  it_behaves_like 'concrete term class'
end
