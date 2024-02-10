# frozen_string_literal: true

RSpec.describe UKAcademicCalendar do
  describe '::VERSION' do
    subject { described_class::VERSION }
    it { is_expected.not_to be nil }
  end

  describe '::SEASONS' do
    subject { described_class::SEASONS }
    it { is_expected.to eq [:autumn, :spring, :summer] }
  end

  shared_examples 'is an Autumn Term' do |ac_year|
    it { is_expected.to be_instance_of(UKAcademicCalendar::AutumnTerm).and have_attributes(academic_year: ac_year) }
  end

  shared_examples 'is a Spring Term' do |ac_year|
    it { is_expected.to be_instance_of(UKAcademicCalendar::SpringTerm).and have_attributes(academic_year: ac_year) }
  end

  shared_examples 'is a Summer Term' do |ac_year|
    it { is_expected.to be_instance_of(UKAcademicCalendar::SummerTerm).and have_attributes(academic_year: ac_year) }
  end

  describe '::all_terms' do
    subject { described_class.all_terms 2023 }
    it do
      is_expected.to be_instance_of(Array)
                 .and have_exactly(3).items
                 .and all be_a_kind_of described_class::Term
    end

    describe '[0]' do
      subject { described_class.all_terms(2023)[0] }
      it_behaves_like 'is an Autumn Term', 2023
    end

    describe '[1]' do
      subject { described_class.all_terms(2023)[1] }
      it_behaves_like 'is a Spring Term', 2023
    end

    describe '[2]' do
      subject { described_class.all_terms(2023)[2] }
      it_behaves_like 'is a Summer Term', 2023
    end
  end

  describe '::autumn_term' do
    subject { described_class.autumn_term 2023 }
    it_behaves_like 'is an Autumn Term', 2023
  end

  describe '::spring_term' do
    subject { described_class.spring_term 2029 }
    it_behaves_like 'is a Spring Term', 2029
  end

  describe '::summer_term' do
    subject { described_class.summer_term 2001 }
    it_behaves_like 'is a Summer Term', 2001
  end

  describe '::term_now' do
    subject { described_class.term_now }

    after { Timecop.return }

    context 'Date.today == 2021-09-01' do
      before { Timecop.freeze(Date.new(2021, 9, 1)) }
      it_behaves_like 'is an Autumn Term', 2021
    end

    context 'Date.today == 2021-12-31' do
      before { Timecop.freeze(Date.new(2021, 12, 31)) }
      it_behaves_like 'is an Autumn Term', 2021
    end

    context 'Date.today == 2022-01-01' do
      before { Timecop.freeze(Date.new(2022, 1, 1)) }
      it_behaves_like 'is a Spring Term', 2021
    end

    context 'Date.today == 2022-04-17 (Easter Sunday)' do
      before { Timecop.freeze(Date.new(2022, 4, 17)) }
      it_behaves_like 'is a Spring Term', 2021
    end

    context 'Date.today == 2022-04-18 (Easter Monday)' do
      before { Timecop.freeze(Date.new(2022, 4, 18)) }
      it_behaves_like 'is a Summer Term', 2021
    end

    context 'Date.today == 2022-08-31' do
      before { Timecop.freeze(Date.new(2022, 8, 31)) }
      it_behaves_like 'is a Summer Term', 2021
    end
  end

  describe '::term_including' do
    subject { described_class.term_including date }

    context '@date == 2021-09-01' do
      let(:date) { Date.new(2021, 9, 1) }
      it_behaves_like 'is an Autumn Term', 2021
    end

    context '@date == 2021-12-31' do
      let(:date) { Date.new(2021, 12, 31) }
      it_behaves_like 'is an Autumn Term', 2021
    end

    context '@date == 2022-01-01' do
      let(:date) { Date.new(2022, 1, 1) }
      it_behaves_like 'is a Spring Term', 2021
    end

    context '@date == 2022-04-17 (Easter Sunday)' do
      let(:date) { Date.new(2022, 4, 17) }
      it_behaves_like 'is a Spring Term', 2021
    end

    context '@date == 2022-04-18 (Easter Monday)' do
      let(:date) { Date.new(2022, 4, 18) }
      it_behaves_like 'is a Summer Term', 2021
    end

    context '@date == 2022-08-31' do
      let(:date) { Date.new(2022, 8, 31) }
      it_behaves_like 'is a Summer Term', 2021
    end
  end
end
