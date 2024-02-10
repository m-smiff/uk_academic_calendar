# frozen_string_literal: true

RSpec.describe UKAcademicCalendar::Term do
  describe '::new' do
    subject { described_class.new(rand(2000..2100)) }

    it do
      expect { subject }
        .to raise_error(AbstractClass::Error, "abstract class #{described_class} can't be instantiated")
    end
  end
end
