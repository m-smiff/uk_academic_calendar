# frozen_string_literal: true

RSpec.describe Integer do
  describe '#to_s' do
    context 'when self == 88' do
      context 'when slash_succ: true' do
        subject { 88.to_s(slash_succ: true) }

        it { is_expected.to eq '88/89' }
      end

      context 'when slash_succ: false' do
        subject { 88.to_s }

        it { is_expected.to eq '88' }
      end
    end

    context 'when self == 2023' do
      context 'when slash_succ: true' do
        subject { 2023.to_s(slash_succ: true) }

        it { is_expected.to eq '2023/2024' }
      end

      context 'when slash_succ: false' do
        subject { 2023.to_s }

        it { is_expected.to eq '2023' }
      end
    end

    context 'when self == 10 and base == 2' do
      context 'when slash_succ: true' do
        subject { 10.to_s(2, slash_succ: true) }

        it { is_expected.to eq '10/11' } # ignores @base
      end

      context 'when slash_succ: false' do
        subject { 10.to_s(2) }

        it { is_expected.to eq '1010' }
      end
    end
  end
end
