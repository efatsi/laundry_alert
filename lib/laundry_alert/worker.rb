module LaundryAlert
  class Worker
    class << self

      def do_work
        Account.watching.each do |account|
          account.get_data

          sleep(2)

          if account.latest_run.finished?
            alert(account)
          end
        end
      end

      def alert(account)
        account.update_attributes(:watching => false)
        machine = account.latest_run.machine_type.capitalize

        LaundryAlert::TwilioClient.send(account.twilio_phone, "#{machine}'s all done. Go get it!")
      end

    end
  end
end
