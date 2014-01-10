class AccountsController < ApplicationController
  before_action :assign_account, :only => [:show, :edit, :update]

  def new
    redirect_to '/account' if logged_in?

    @account = Account.new
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      cookies.permanent[:account_id] = @account.id
      redirect_to '/account'
    else
      render :new
    end
  end

  def login
    phone = params[:existing_account][:phone].gsub(/[^0-9]/, "")

    if account = Account.find_by_phone(phone)
      cookies.permanent[:account_id] = account.id
      redirect_to '/account'
    else
      redirect_to root_url
    end
  end

  def show
    redirect_to '/' unless logged_in?
  end

  def edit
  end

  def update
    if @account.update_attributes(account_params)
      redirect_to '/account'
    else
      render :edit
    end
  end

  # private

  def logged_in?
    current_account.present?
  end

  def current_account
    Account.find(cookies[:account_id]) if cookies[:account_id]
  rescue
    cookies[:account_id] = nil
    return false
  end

  def assign_account
    @account = current_account
  end

  def account_params
    params[:account].permit!
  end
end
