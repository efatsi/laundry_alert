module LaundryAlert
  class Worker

    class << self

      def do_work
        Account.watching.each do |account|
          alert(account) if account.core.analog_read(6) < 500
        end
      end

      def alert(account)
        account.update_attributes(:watching => false)
        LaundryAlert::TwilioClient.send(account.twilio_phone, "Laundry's all done. Go get it!")
      end

    end

  end
end
