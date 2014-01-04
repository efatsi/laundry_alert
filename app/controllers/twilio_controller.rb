class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def process_sms
    if account = Account.find_by_phone(params[:From][2,10])
      handler = LaundryAlert::TextHandler.new(account, params[:Body])
      @response = handler.response
    else
      @response = "Looks like you're not signed up on http://laundryalert.herokuapp.com."
    end

    render 'response.xml.erb', :content_type => 'text/xml'
  end

end
