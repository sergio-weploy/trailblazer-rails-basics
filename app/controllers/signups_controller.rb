class SignupsController < ApplicationController
  def new
    run User::Signup::Present
  end

  def create
    run User::Signup do |result|
      return redirect_to root_url, notice: 'Yay its working!'
    end
    flash.now[:alert] = 'Woops, something went wrong'
    render 'new'
  end

end
