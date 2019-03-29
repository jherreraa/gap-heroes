class Api::V1::HeroesController < ApplicationController
  before_action :set_hero, only: [:show, :edit, :update, :destroy]

  # GET /heroes
  # GET /heroes.json
  def index    
      @heroes = Heroe.page params[:page]
      if params[:page].nil?
        set_pagination_headers(1)
      else
        set_pagination_headers(params[:page])
      end
      render json: @heroes      
  end

  # GET /heroes/1
  # GET /heroes/1.json
  def show
    render json: @hero
  end

  # GET /heroes/new
  def new
    @hero = Heroe.new
  end

  # GET /heroes/1/edit
  def edit
  end

  # POST /heroes
  # POST /heroes.json
  def create
    @hero = Heroe.new(hero_params)
      
    respond_to do |format|
      if @hero.save
        format.json { render json: @hero, status: :created, location: api_v1_heroes_url(@hero) }
      else
        format.json { render json: @hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heroes/1
  # PATCH/PUT /heroes/1.json
  def update
    respond_to do |format|
      if @hero.update(hero_params)        
        format.json { render json: @hero, status: :ok, location: api_v1_heroes_url(@hero) }
      else        
        format.json { render json: @hero.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heroes/1
  # DELETE /heroes/1.json
  def destroy
    @hero.destroy     
    render status: 204, json: {
        message: ""
    }.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hero
      @hero = Heroe.find(params[:id])      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hero_params
      params.require(:hero).permit(:universe_id, :name, :real_name, :species)
    end

    def set_pagination_headers(page)
      headers["X-Total"] = Heroe.all.count
      headers["X-Total-Pages"] = (Heroe.all.count.to_f/Heroe.page.count.to_f).ceil      
      headers["X-Page"] = page
      headers["X-Per-Page"] = Heroe.page.count
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
