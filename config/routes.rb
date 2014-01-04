LaundryAlert::Application.routes.draw do
  root 'accounts#new'
  post 'twilio/process_sms', :to => 'twilio#process_sms'
  get 'check_em', :to => 'worker#go'

  resource :account
  resources :runs, :only => [:show]
end
