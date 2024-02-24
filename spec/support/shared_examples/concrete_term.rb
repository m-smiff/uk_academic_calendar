# frozen_string_literal: true

RSpec.shared_examples 'concrete term class' do
  describe '#hash' do
    include_context 'when for random academic year'

    before do
      subject.start_date = start_date
      subject.end_date = end_date
    end

    let(:start_date) { assert_nominal_start_date + 2 }
    let(:end_date) { assert_nominal_end_date - 10 }

    it do
      expect(subject.hash).to be_instance_of(Integer)
                          .and be [described_class, academic_year, start_date, end_date].hash
    end
  end

  describe '#eql?' do
    include_context 'when for random academic year'

    context 'when other of different class' do
      let(:other) do
        klass = UKAcademicCalendar::Term.descendants.shuffle.find { |c| c != described_class }
        klass.new(academic_year)
      end

      it { expect(subject.eql?(other)).to be false }
    end

    context 'when other of same class' do
      let(:other) { described_class.new(other_academic_year) }

      context 'when other#academic_year == #academic_year' do
        let(:other_academic_year) { subject.academic_year }

        it { expect(subject.eql?(other)).to be true }

        context 'when other#start_date != #start_date' do
          before { other.start_date = subject.start_date.next_day }

          it { expect(subject.eql?(other)).to be false }
        end

        context 'when other#end_date != #end_date' do
          before { other.end_date = subject.end_date.prev_day }

          it { expect(subject.eql?(other)).to be false }
        end
      end

      context 'when other#academic_year != #academic_year' do
        let(:other_academic_year) { subject.academic_year - 1 }

        it { expect(subject.eql?(other)).to be false }
      end
    end
  end

  describe '#academic_year' do
    include_context 'when for random academic year'
    it { expect(subject.academic_year).to eq academic_year }
  end

  describe '#season' do
    subject { described_class.new(Date.today.academic_year).season }

    it { is_expected.to be assert_season }
  end

  describe '#inspect' do
    include_context 'when for random academic year'
    it { expect(subject.inspect).to eq subject.to_s }
  end

  describe '#to_s' do
    include_context 'when for random academic year'
    it do
      expect(subject.to_s).to eq "#{assert_season.to_s.titleize} #{academic_year}/#{academic_year.succ}"
    end
  end

  describe '#nominal_start_date' do
    include_context 'when for random academic year'
    it { expect(subject.nominal_start_date).to eq assert_nominal_start_date }
  end

  describe '#nominal_end_date' do
    include_context 'when for random academic year'
    it { expect(subject.nominal_end_date).to eq assert_nominal_end_date }
  end

  describe '#start_date' do
    include_context 'when for random academic year'
    it { expect(subject.start_date).to eq subject.nominal_start_date }
  end

  describe '#end_date' do
    include_context 'when for random academic year'
    it { expect(subject.end_date).to eq subject.nominal_end_date }
  end

  describe '#start_date=' do
    include_context 'when for random academic year'

    context 'when val is in bounds' do
      let(:new_start_date) { assert_nominal_start_date + 5 }

      it do
        expect { subject.start_date = new_start_date }
          .to change(subject, :start_date).from(assert_nominal_start_date)
                                          .to(new_start_date)
      end
    end

    context 'when val is out of bounds' do
      let(:new_start_date) { assert_nominal_start_date - 5 }

      it do
        expect { subject.start_date = new_start_date }
          .to raise_error(
            UKAcademicCalendar::InvalidTermStart,
            "#{new_start_date} is invalid. Must be within #{subject.start_date..subject.end_date}"
          )
      end
    end

    context 'when val > #end_date' do
      let(:end_date) { assert_nominal_end_date - 15 }
      let(:new_start_date) { assert_nominal_end_date - 14 }

      before { subject.end_date = end_date }

      it do
        expect { subject.start_date = new_start_date }
          .to raise_error(
            UKAcademicCalendar::InvalidTermStart,
            "#{new_start_date} is invalid. Must be < #{end_date}"
          )
      end
    end
  end

  describe '#end_date=' do
    include_context 'when for random academic year'

    context 'when val is in bounds' do
      let(:new_end_date) { assert_nominal_end_date - 8 }

      it do
        expect { subject.end_date = new_end_date }
          .to change(subject, :end_date).from(assert_nominal_end_date)
                                        .to(new_end_date)
      end
    end

    context 'when val is out of bounds' do
      let(:new_end_date) { assert_nominal_end_date + 1 }

      it do
        expect { subject.end_date = new_end_date }
          .to raise_error(
            UKAcademicCalendar::InvalidTermEnd,
            "#{new_end_date} is invalid. Must be within #{subject.start_date..subject.end_date}"
          )
      end
    end

    context 'when val < #start_date' do
      let(:start_date) { assert_nominal_start_date + 15 }
      let(:new_end_date) { assert_nominal_start_date + 14 }

      before { subject.start_date = start_date }

      it do
        expect { subject.end_date = new_end_date }
          .to raise_error(
            UKAcademicCalendar::InvalidTermEnd,
            "#{new_end_date} is invalid. Must be > #{start_date}"
          )
      end
    end
  end

  describe '#to_range' do
    include_context 'when for random academic year'

    it { expect(subject.to_range).to eq assert_nominal_start_date..assert_nominal_end_date }

    context 'when #start_date && #end_date assigned' do
      let(:new_start_date) { assert_nominal_start_date + 10 }
      let(:new_end_date) { assert_nominal_end_date - 10 }

      before do
        subject.start_date = new_start_date
        subject.end_date = new_end_date
      end

      it { expect(subject.to_range).to eq new_start_date..new_end_date }
    end
  end

  describe '#all_dates' do
    include_context 'when for random academic year'

    it { expect(subject.all_dates).to eq SortedSet.new((assert_nominal_start_date..assert_nominal_end_date).to_a) }

    context 'when #start_date && #end_date assigned' do
      let(:new_start_date) { assert_nominal_start_date + 10 }
      let(:new_end_date) { assert_nominal_end_date - 10 }

      before do
        subject.start_date = new_start_date
        subject.end_date = new_end_date
      end

      it { expect(subject.all_dates).to eq SortedSet.new((new_start_date..new_end_date).to_a) }
    end
  end

  describe 'def_delegators' do
    describe '#all_dates' do
      describe '#include?' do
        include_context 'when for random academic year'

        context 'when date within #all_dates' do
          let(:date) { assert_nominal_start_date }

          it { expect(subject.include?(date)).to be true }
        end

        context 'when date not within #all_dates' do
          let(:date) { assert_nominal_start_date - 1 }

          it { expect(subject.include?(date)).to be false }
        end
      end

      describe '#each' do
        include_context 'when for random academic year'
        it { expect(subject.each).to be_instance_of(Enumerator) }
      end
    end
  end
end
