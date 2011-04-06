class ObituariesController < ApplicationController
  # GET /obituaries
  def index
    @search = Obituary.search(params[:search])
    @obituaries = @search.page(params[:page])
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
