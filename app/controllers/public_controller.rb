class PublicController < ApplicationController
  def home
    @client = current_client
  end
end
