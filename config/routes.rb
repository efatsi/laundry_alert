LaundryAlert::Application.routes.draw do
  root 'accounts#new'

  resource :account
end
