# frozen_string_literal: true

module UKAcademicCalendar
  # Mixin included in Integer class
  module SuccSlashable
    # @param base [Integer]
    # @param slash_succ [Boolean] option specifying whether to leverage the "slash_succ" option
    # @return [String] string where self is concatenated with the value succeeding self, seperated by a forward slash
    # @example
    #   2023.to_s(slash_succ: true) #=> "2023/2024"
    def to_s(base = 10, slash_succ: false)
      if slash_succ
        "#{to_i}/#{to_i.succ}"
      else
        super(base)
      end
    end
  end
end
