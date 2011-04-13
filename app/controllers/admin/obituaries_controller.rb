class Admin::ObituariesController < ApplicationController
  layout 'admin'
  
  def index
    @obituaries = Obituary.search(params[:search],search_options).page(params[:page])
  end

  def show
    @obituary = Obituary.find(params[:id])
  end

  def new
    @obituary = Obituary.new
  end

  def create
    @obituary = Obituary.new(params[:obituary])
    if @obituary.save
      redirect_to [:admin, @obituary], :notice => "Successfully created obituary."
    else
      render :action => 'new'
    end
  end

  def edit
    @obituary = Obituary.find(params[:id])
  end

  def update
    @obituary = Obituary.find(params[:id])
    if @obituary.update_attributes(params[:obituary])
      redirect_to [:admin, @obituary], :notice  => "Successfully updated obituary."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @obituary = Obituary.find(params[:id])
    @obituary.destroy
    redirect_to admin_obituaries_url, :notice => "Successfully destroyed obituary."
  end
end
