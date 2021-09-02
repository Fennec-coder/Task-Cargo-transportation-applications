require 'calculation_of_cargo'

class CargosController < ApplicationController
  include CalculationOfCargo
  before_action :authenticate_client!

  def index
    @request = Request.find(params[:request_id])
    @cargos = Cargo.where(request_id: params[:request_id])
    @price = Hash.new

    @cargos.each do |cargo|
      @price.store(cargo.id, price_of_cargo(@request, cargo))
    end
  end

  def show
    @cargo = Cargo.find(params[:id])
    @request = Request.find(@cargo.request_id)
    @price = price_of_cargo(@request, @cargo)
  end

  def new
    @request = Request.find(params[:request_id])
    @cargo = Cargo.new
  end

  # since there can be more than one cargo during one transportation,
  # then the cargo has a transportation (request) ID to which it belongs
  def create
    @request = Request.find(params[:request_id])
    @cargo = Cargo.new(cargo_params)
    @cargo.request_id = params[:request_id]
      if @cargo.save
      redirect_to request_cargo_path(@request, @cargo), flash: {success: 'Cargo was added'}
    else
      render :new, flash: {alert: 'Some error occured'}
    end
  end

  def edit
    @cargo = Cargo.find(params[:id])
  end

  def update
    cargo = Cargo.find(params[:id])
    cargo.update(request_params)
    redirect_to cargo, flash: {success: 'Cargo was updated'}
  end

  def destroy
    @cargo = Cargo.find(params[:id])
    id_of_request = @cargo.request_id
    @cargo.destroy

    redirect_to request_path(id_of_request)
  end

  def cargo_params
    params.require(:cargo).permit(:weight, :length , :width, :height, :request_id)
  end
end
