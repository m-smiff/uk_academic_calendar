# frozen_string_literal: true

RSpec.describe UKAcademicCalendar::Term do
  describe '::new' do
    let(:abstract_term) { described_class.new(rand(2000..2100)) }

    it do
      expect { abstract_term }
        .to raise_error(AbstractClass::Error, "abstract class #{described_class} can't be instantiated")
    end
  end
end
