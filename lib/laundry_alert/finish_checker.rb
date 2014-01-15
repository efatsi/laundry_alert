module LaundryAlert
  class FinishChecker

    def self.finished?(run)
      new(run).finished?
    end

    def initialize(run)
      @run     = run
      @data    = run.raw_data
      @account = run.account
    end

    def finished?
      @data.any? && stopped? && (high_cycle_passed? || machine_is_done?)
    end

    # private

    def stopped?
      @data.last < @account.low_threshold
    end

    # need 3 in a row over the threshold
    def high_cycle_passed?
      (@data.count - 3).times do |i|
        if (@data[i]   > threshold) && (@data[i+1] > threshold) &&
           (@data[i+2] > threshold)
          return true
        end
      end

      return false
    end

    def machine_is_done?
      high_point_reached? && in_serious_low_cycle?
    end

    def in_serious_low_cycle?
      return false if @data.length < 6

      @data[@data.length-6..@data.length].each do |reading|
        return false if reading > @account.high_threshold
      end

      return true
    end

    def high_point_reached?
      @data.each do |reading|
        return true if reading > threshold
      end

      return false
    end

    def threshold
      @threshold ||= if @run.washer?
        @account.high_threshold
      else
        @account.low_threshold
      end
    end

  end
end
