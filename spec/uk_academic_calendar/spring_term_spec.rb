# frozen_string_literal: true

RSpec.describe UKAcademicCalendar::SpringTerm do
  let(:assert_season) { :spring }
  let(:assert_nominal_start_date) { Date.new(academic_year + 1, 1, 1) }
  let(:assert_nominal_end_date) { Easter.easter(academic_year + 1) }

  it_behaves_like 'concrete term class'
end
