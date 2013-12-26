module LaundryAlert
  class TwilioClient

    class << self
      def test
        puts "HEY"
      end

      def send(to, body)
        client.account.messages.create({
          :from => "+15052253781",
          :to   => to,
          :body => body
        })
      end

      def client
        @client = Twilio::REST::Client.new(
          ENV["TWILIO_ACCOUNT_SID"],
          ENV["TWILIO_AUTH_TOKEN"]
        )
      end
    end

  end
end
