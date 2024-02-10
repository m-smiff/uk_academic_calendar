# frozen_string_literal: true

RSpec.shared_context 'for random academic year' do
  let(:academic_year) { rand(1900..2100) }
  subject { described_class.new(academic_year) }
end
