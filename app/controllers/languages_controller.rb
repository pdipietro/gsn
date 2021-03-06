class LanguagesController < ApplicationController
  before_action :set_language, only: [:show, :edit, :update, :destroy]

  respond_to :js

  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all.order(code: :asc)

#    @languages = Neo4j::Session.query("match (language:Language)<-[owns:owns]-(owner:Subject) return language,owner.uuid as owner_uuid")

  end

  # GET /languages/1
  # GET /languages/1.json
  def show
  end

  # GET /languages/new
  def new
    @language = Language.new
  end

  # GET /languages/1/edit
  def edit
  end

  # POST /languages
  # POST /languages.json
  def create
    @language = Language.new(language_params)
    
    respond_to do |format|
      if @language.save
         rel = Owns.create(from_node: current_subject, to_node: @language)  

         format.js   { render partial: "enqueue", object: @language, notice: 'Language was successfully created.' }
         format.html { redirect_to @language, notice: 'Language was successfully created.' }
         format.json { render :show, status: :created, location: @language }
      else
        format.js   { render :new, object: @language }
        format.html { render :new }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /languages/1
  # PATCH/PUT /languages/1.json
  def update
    respond_to do |format|
      if @language.update(language_params)
        format.js   { render partial: "replace", object: @language, notice: 'Language was successfully updated.' }
        format.html { redirect_to @language, notice: 'Language was successfully updated.' }
        format.json { render :show, status: :ok, location: @language }
      else
        format.js   { render :edit, object: @language }
        format.html { render :edit }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.json
  def destroy
    dest = @language.uuid
    @language.destroy
    respond_to do |format|
      format.js   { render partial: "shared/remove", locals: { dest: dest } }
      format.html { redirect_to languages_url, notice: 'Language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_all
    Language.all.order(code: :asc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_language
      @language = Language.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def language_params
      params.require(:language).permit(:code, :description)
    end
end
