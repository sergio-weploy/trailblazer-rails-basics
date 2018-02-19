class SignupsController < ApplicationController
  def new
    run User::Signup::Present
  end

  def create
    run User::Signup::Present do |result|
    end
    render 'new'
  end
end
