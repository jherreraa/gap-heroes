class Api::V1::UniversesController < ApplicationController
  before_action :set_universe, only: [:show, :edit, :update, :destroy]

  # GET /universes
  # GET /universes.json
  def index
      @universes = Universe.page params[:page]
      if params[:page].nil?
        set_pagination_headers(1)
      else
        set_pagination_headers(params[:page])
      end
      render json: @universes
  end

  # GET /universes/1
  # GET /universes/1.json
  def show
    render json: @universe
  end

  # GET /universes/new
  def new
    @universe = Universe.new
  end

  # GET /universes/1/edit
  def edit
  end

  # POST /universes
  # POST /universes.json
  def create
    @universe = Universe.new(universe_params)
      
    respond_to do |format|
      if @universe.save        
        format.json { render json: @universe, status: :created, location: api_v1_universe_url(@universe) }
      else        
        format.json { render json: @universe.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /universes/1
  # PATCH/PUT /universes/1.json
  def update   
    #respond_to do |format|
      if @universe.update(universe_params)
        #format.html { redirect_to @universe, notice: 'Universe was successfully updated.' }
        #format.json { render :show, status: :ok, location: @universe }
        #format.json { render json: @universe, status: :ok, location: api_v1_universe_url(@universe) }
        render json: @universe
      else
        #format.html { render :edit }
        #format.json { render json: @universe.errors, status: :unprocessable_entity }
        render json: @universe.errors, status: :unprocessable_entity
      end
    #end
  end

  # DELETE /universes/1
  # DELETE /universes/1.json
  def destroy
    @universe.destroy
    #respond_to do |format|
    #  format.html { redirect_to universes_url, notice: 'Universe was successfully destroyed.' }
      #render json: head :no_content
      #render json: {
      #  status: 204,
      #  message: ""        
      #}.to_json
      render status: 204, json: {
        message: ""
      }.to_json
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_universe
      @universe = Universe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def universe_params      
      params.require(:universe).permit(:name)
    end

    def set_pagination_headers(page)
      headers["X-Total"] = Universe.all.count
      headers["X-Total-Pages"] = (Universe.all.count.to_f/Universe.page.count.to_f).ceil      
      headers["X-Page"] = page
      headers["X-Per-Page"] = Universe.page.count
      if page > headers["X-Total-Pages"]
        headers["X-Next-Page"] = page + 1
      else
        headers["X-Next-Page"] = headers["X-Total-Pages"]
      end
      if page == 1
        headers["X-Prev-Page"] = 1
      else
        headers["X-Prev-Page"] = page - 1
      end
    end    
end
