class ObituariesController < ApplicationController
  # GET /obituaries
  def index
    if params[:range].present?
      @range = params[:range].split(",")
      @range = Time.parse(@range.first)..Time.parse(@range.last)
    end
    @obituaries = Obituary.search(params[:search],
      :star => true,
      :match_mode => :any,
      :field_weights => {
        :full_name  => 10,
        :name       => 8,
        :last_name  => 6,
        :first_name => 2
      },
      :with => {
        :died_on => @range
      }
      ).page(params[:page])
  end

  # GET /obituaries/new
  def new
    @obituary = Obituary.new
  end

  # GET /obituaries/1/edit
  def edit
    @obituary = Obituary.find(params[:id])
  end

  # POST /obituaries
  def create
    @obituary = Obituary.new(params[:obituary])

    if @obituary.save
      redirect_to(@obituary, :notice => 'Obituary was successfully created.')
    else
      render :action => "new"
    end
  end

  # PUT /obituaries/1
  def update
    @obituary = Obituary.find(params[:id])

    if @obituary.update_attributes(params[:obituary])
      redirect_to(@obituary, :notice => 'Obituary was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /obituaries/1
  def destroy
    @obituary = Obituary.find(params[:id])
    @obituary.destroy

    redirect_to(obituaries_url)
  end
end
