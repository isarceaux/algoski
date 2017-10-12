class ChargesController < ApplicationController

  def new
  end

  def create
  
  account_type = params[:account_type]
  
  if account_type == 'professional'
    @amount = 24900 # Amount in cents

  elsif account_type == 'individual'
    @amount = 4900 # Amount in cents
  
  elsif account_type == 'professional-upgrade'
    @amount = 20000
    account_type = 'professional'
  else
    redirect_to new_charge_path
  end

  customer = Stripe::Customer.create(
    :email => params[:stripeEmail],
    :source  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'eur'
  )
  if charge
    current_user.account = account_type
   
    current_user.subscriptions.each do |s|
      s.destroy
    end

    current_user.save
  end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
