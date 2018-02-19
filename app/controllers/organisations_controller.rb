class OrganisationsController < ApplicationController

  def new
    run Organisation::Create::Present
  end

  def create
    run Organisation::Create do |result|
      return redirect_to root_url, notice: result["result.success_message"]
    end
    flash.now[:alert] = 'Woops, something went wrong'
    render 'new'
  end
end
