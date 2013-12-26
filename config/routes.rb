LaundryAlert::Application.routes.draw do
  root 'accounts#new'
  post 'twilio/process_sms', :to => 'twilio#process_sms'

  resource :account
end
