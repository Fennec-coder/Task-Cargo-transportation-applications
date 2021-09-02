class ClientsController < ApplicationController
  before_action :authenticate_client!

  def show
    @client = current_client
    @requests = Request.where(client_id: @client.id)
  end
end
