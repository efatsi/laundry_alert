class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def process_sms
    if account = Account.find_by_phone(params[:From][2,10])
      account.update_attributes(:watching => true)
      @response = random_response
    else
      @response = "Looks like you're not signed up on laundryalert.herokuapp.com."
    end

    render 'response.xml.erb', :content_type => 'text/xml'
  end

  private

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
