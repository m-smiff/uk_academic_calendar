# frozen_string_literal: true

RSpec.describe Time do
  [rand(1920..1950), rand(1951..2003), rand(2004..2100)].each do |cal_year|
    context "when calendar year = #{cal_year}" do
      describe '#academic_year' do
        subject { time.academic_year }

        context 'when now == 1st Jan, 12:00' do
          let(:time) { described_class.new(cal_year, 1, 1).midday }

          it { is_expected.to eq(cal_year - 1) }
        end

        context 'when now == 31st Aug, 12:00' do
          let(:time) { described_class.new(cal_year, 8, 31).midday }

          it { is_expected.to eq(cal_year - 1) }
        end

        context 'when now == 1st Sept, 12:00' do
          let(:time) { described_class.new(cal_year, 9, 1).midday }

          it { is_expected.to eq cal_year }
        end

        context 'when now == 31st Dec, 12:00' do
          let(:time) { described_class.new(cal_year, 12, 31).midday }

          it { is_expected.to eq cal_year }
        end
      end

      describe '#beginning_of_academic_year' do
        subject { time.beginning_of_academic_year }

        context 'when now == 1st Jan, 12:00' do
          let(:time) { described_class.new(cal_year, 1, 1).midday }

          it { is_expected.to eq described_class.new(cal_year - 1, 9, 1).beginning_of_day }
        end

        context 'when now == 31st Aug, 12:00' do
          let(:time) { described_class.new(cal_year, 8, 31).midday }

          it { is_expected.to eq described_class.new(cal_year - 1, 9, 1).beginning_of_day }
        end

        context 'when now == 1st Sept, 12:00' do
          let(:time) { described_class.new(cal_year, 9, 1).midday }

          it { is_expected.to eq time.beginning_of_day }
        end

        context 'when now == 31st Dec, 12:00' do
          let(:time) { described_class.new(cal_year, 12, 31).midday }

          it { is_expected.to eq described_class.new(cal_year, 9, 1).beginning_of_day }
        end
      end

      describe '#end_of_academic_year' do
        subject { time.end_of_academic_year }

        context 'when now == 1st Jan, 12:00' do
          let(:time) { described_class.new(cal_year, 1, 1).midday }

          it { is_expected.to eq described_class.new(cal_year, 8, 31).end_of_day }
        end

        context 'when now == 31st Aug, 12:00' do
          let(:time) { described_class.new(cal_year, 8, 31).midday }

          it { is_expected.to eq time.end_of_day }
        end

        context 'when now == 1st Sept, 12:00' do
          let(:time) { described_class.new(cal_year, 9, 1).midday }

          it { is_expected.to eq described_class.new(cal_year + 1, 8, 31).end_of_day }
        end

        context 'when now == 31st Dec, 12:00' do
          let(:time) { described_class.new(cal_year, 12, 31).midday }

          it { is_expected.to eq described_class.new(cal_year + 1, 8, 31).end_of_day }
        end
      end

      describe '#academic_year_month' do
        subject { time.academic_year_month }

        context 'when now == 1st Jan, 12:00' do
          let(:time) { described_class.new(cal_year, 1, 1).midday }

          it { is_expected.to be 5 }
        end

        context 'when now == 31st Aug, 12:00' do
          let(:time) { described_class.new(cal_year, 8, 31).midday }

          it { is_expected.to be 12 }
        end

        context 'when now == 1st Sept, 12:00' do
          let(:time) { described_class.new(cal_year, 9, 1).midday }

          it { is_expected.to be 1 }
        end

        context 'when now == 31st Dec, 12:00' do
          let(:time) { described_class.new(cal_year, 12, 31).midday }

          it { is_expected.to be 4 }
        end
      end

      describe '#academic_term' do
        subject { time.academic_term }

        context 'when now == 1st Jan, 12:00' do
          let(:time) { described_class.new(cal_year, 1, 1).midday }

          it { is_expected.to eq UKAcademicCalendar::SpringTerm.new(cal_year - 1) }
        end

        context 'when now == 31st Aug, 12:00' do
          let(:time) { described_class.new(cal_year, 8, 31).midday }

          it { is_expected.to eq UKAcademicCalendar::SummerTerm.new(cal_year - 1) }
        end

        context 'when now == 1st Sept, 12:00' do
          let(:time) { described_class.new(cal_year, 9, 1).midday }

          it { is_expected.to eq UKAcademicCalendar::AutumnTerm.new(cal_year) }
        end

        context 'when now == 31st Dec, 12:00' do
          let(:time) { described_class.new(cal_year, 12, 31).midday }

          it { is_expected.to eq UKAcademicCalendar::AutumnTerm.new(cal_year) }
        end
      end

      describe '#beginning_of_academic_term' do
        subject { time.beginning_of_academic_term }

        context 'when now == 1st Jan, 12:00' do
          let(:time) { described_class.new(cal_year, 1, 1).midday }

          it { is_expected.to eq time.beginning_of_day }
        end

        context 'when now == 31st Aug, 12:00' do
          let(:time) { described_class.new(cal_year, 8, 31).midday }

          it { is_expected.to eq Easter.easter(cal_year).next_day.beginning_of_day }
        end

        context 'when now == 1st Sept, 12:00' do
          let(:time) { described_class.new(cal_year, 9, 1).midday }

          it { is_expected.to eq time.beginning_of_day }
        end

        context 'when now == 31st Dec, 12:00' do
          let(:time) { described_class.new(cal_year, 12, 31).midday }

          it { is_expected.to eq Date.new(cal_year, 9, 1).beginning_of_day }
        end
      end

      describe '#end_of_academic_term' do
        subject { time.end_of_academic_term }

        context 'when now == 1st Jan, 12:00' do
          let(:time) { described_class.new(cal_year, 1, 1) }

          it { is_expected.to eq Easter.easter(cal_year).end_of_day }
        end

        context 'when now == 31st Aug, 12:00' do
          let(:time) { described_class.new(cal_year, 8, 31) }

          it { is_expected.to eq time.end_of_day }
        end

        context 'when now == 1st Sept, 12:00' do
          let(:time) { described_class.new(cal_year, 9, 1) }

          it { is_expected.to eq Date.new(cal_year, 12, 31).end_of_day }
        end

        context 'when now == 31st Dec, 12:00' do
          let(:time) { described_class.new(cal_year, 12, 31) }

          it { is_expected.to eq time.end_of_day }
        end
      end
    end
  end
end
