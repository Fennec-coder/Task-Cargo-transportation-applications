class PublicController < ApplicationController
  def home
    @client = current_client
    @requests = @client.nil? ? [] : Request.where(client_id: @client.id)
  end
end
