# frozen_string_literal: true

RSpec.shared_context 'when for random academic year' do
  subject { described_class.new(academic_year) }

  let(:academic_year) { rand(1900..2100) }
end
