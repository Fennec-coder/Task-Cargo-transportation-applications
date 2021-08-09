class CargosController < ApplicationController
  def index
    @cargos = Cargo.all
  end

  def show
    @cargos = Cargo.find(params[:id])
    @request = Request.find(@cargos.request_id)
  end

  def new
    @cargos = Cargo.new
  end

  # since there can be more than one cargo during one transportation,
  # then the cargo has a transportation (request) ID to which it belongs
  def create
    @cargos = Cargo.new(cargo_params)
    if @cargos.save
      redirect_to @cargos, flash: {success: 'Cargo was added'}
    else
      render :new, flash: {alert: 'Some error occured'}
    end
  end

  def edit
    @cargos = Cargo.find(params[:id])
  end

  def update
    cargo = Cargo.find(params[:id])
    cargo.update(request_params)
    redirect_to cargo, flash: {success: 'Cargo was updated'}
  end

  def destroy
    @cargos = Cargo.find(params[:id])
    id_of_request = @cargos.request_id
    @cargos.destroy

    redirect_to request_path(id_of_request)
  end

  def cargo_params
    params.require(:cargo).permit(:weight, :length , :width, :height, :request_id)
  end

end
