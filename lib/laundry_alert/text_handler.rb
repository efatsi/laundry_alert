module LaundryAlert
  class TextHandler

    def initialize(account, text)
      @account = account
      @text    = text.downcase
    end

    def response
      if @text.include? 'configure'
        @account.configure
      else
        @account.watch(machine_type)
      end

      random_response
    end

    # private

    def machine_type
      @text.include?('dryer') ? 'dryer' : 'washer'
    end

    def random_response
      [
        "Okidokee!",
        "You got it!",
        "No problem bud!",
        "Tally ho!",
        "Right on!",
        "All set!"
      ].sample
    end

  end
end
