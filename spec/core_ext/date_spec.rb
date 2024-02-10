# frozen_string_literal: true

RSpec.describe Date do
  [rand(1920..1950), rand(1951..2003), rand(2004..2100)].each do |cal_year|
    context "calendar year = #{cal_year}" do
      describe '#academic_year' do
        subject { date.academic_year }

        context 'today == 1st Jan' do
          let(:date) { described_class.new(cal_year, 1, 1) }
          it { is_expected.to eq(cal_year - 1) }
        end

        context 'today == 31st Aug' do
          let(:date) { described_class.new(cal_year, 8, 31) }
          it { is_expected.to eq(cal_year - 1) }
        end

        context 'today == 1st Sept' do
          let(:date) { described_class.new(cal_year, 9, 1) }
          it { is_expected.to eq cal_year }
        end

        context 'today == 31st Dec' do
          let(:date) { described_class.new(cal_year, 12, 31) }
          it { is_expected.to eq cal_year }
        end
      end

      describe '#beginning_of_academic_year' do
        subject { date.beginning_of_academic_year }

        context 'today == 1st Jan' do
          let(:date) { described_class.new(cal_year, 1, 1) }
          it { is_expected.to eq described_class.new(cal_year - 1, 9, 1) }
        end

        context 'today == 31st Aug' do
          let(:date) { described_class.new(cal_year, 8, 31) }
          it { is_expected.to eq described_class.new(cal_year - 1, 9, 1) }
        end

        context 'today == 1st Sept' do
          let(:date) { described_class.new(cal_year, 9, 1) }
          it { is_expected.to eq date }
        end

        context 'today == 31st Dec' do
          let(:date) { described_class.new(cal_year, 12, 31) }
          it { is_expected.to eq described_class.new(cal_year, 9, 1) }
        end
      end

      describe '#end_of_academic_year' do
        subject { date.end_of_academic_year }

        context 'today == 1st Jan' do
          let(:date) { described_class.new(cal_year, 1, 1) }
          it { is_expected.to eq described_class.new(cal_year, 8, 31) }
        end

        context 'today == 31st Aug' do
          let(:date) { described_class.new(cal_year, 8, 31) }
          it { is_expected.to eq date }
        end

        context 'today == 1st Sept' do
          let(:date) { described_class.new(cal_year, 9, 1) }
          it { is_expected.to eq described_class.new(cal_year + 1, 8, 31) }
        end

        context 'today == 31st Dec' do
          let(:date) { described_class.new(cal_year, 12, 31) }
          it { is_expected.to eq described_class.new(cal_year + 1, 8, 31) }
        end
      end

      describe '#academic_year_month' do
        subject { date.academic_year_month }

        context 'today == 1st Jan' do
          let(:date) { described_class.new(cal_year, 1, 1) }
          it { is_expected.to be 5 }
        end

        context 'today == 31st Aug' do
          let(:date) { described_class.new(cal_year, 8, 31) }
          it { is_expected.to be 12 }
        end

        context 'today == 1st Sept' do
          let(:date) { described_class.new(cal_year, 9, 1) }
          it { is_expected.to be 1 }
        end

        context 'today == 31st Dec' do
          let(:date) { described_class.new(cal_year, 12, 31) }
          it { is_expected.to be 4 }
        end
      end

      describe '#academic_term' do
        subject { date.academic_term }

        context 'today == 1st Jan' do
          let(:date) { described_class.new(cal_year, 1, 1) }
          it { is_expected.to eq UKAcademicCalendar::SpringTerm.new(cal_year - 1) }
        end

        context 'today == 31st Aug' do
          let(:date) { described_class.new(cal_year, 8, 31) }
          it { is_expected.to eq UKAcademicCalendar::SummerTerm.new(cal_year - 1) }
        end

        context 'today == 1st Sept' do
          let(:date) { described_class.new(cal_year, 9, 1) }
          it { is_expected.to eq UKAcademicCalendar::AutumnTerm.new(cal_year) }
        end

        context 'today == 31st Dec' do
          let(:date) { described_class.new(cal_year, 12, 31) }
          it { is_expected.to eq UKAcademicCalendar::AutumnTerm.new(cal_year) }
        end
      end

      describe '#beginning_of_academic_term' do
        subject { date.beginning_of_academic_term }

        context 'today == 1st Jan' do
          let(:date) { described_class.new(cal_year, 1, 1) }
          it { is_expected.to eq date }
        end

        context 'today == 31st Aug' do
          let(:date) { described_class.new(cal_year, 8, 31) }
          it { is_expected.to eq Easter.easter(cal_year).next_day }
        end

        context 'today == 1st Sept' do
          let(:date) { described_class.new(cal_year, 9, 1) }
          it { is_expected.to eq date }
        end

        context 'today == 31st Dec' do
          let(:date) { described_class.new(cal_year, 12, 31) }
          it { is_expected.to eq described_class.new(cal_year, 9, 1) }
        end
      end
    end

    describe '#end_of_academic_term' do
      subject { date.end_of_academic_term }

      context 'today == 1st Jan' do
        let(:date) { described_class.new(cal_year, 1, 1) }
        it { is_expected.to eq Easter.easter cal_year }
      end

      context 'today == 31st Aug' do
        let(:date) { described_class.new(cal_year, 8, 31) }
        it { is_expected.to eq date }
      end

      context 'today == 1st Sept' do
        let(:date) { described_class.new(cal_year, 9, 1) }
        it { is_expected.to eq described_class.new(cal_year, 12, 31) }
      end

      context 'today == 31st Dec' do
        let(:date) { described_class.new(cal_year, 12, 31) }
        it { is_expected.to eq date }
      end
    end
  end
end
