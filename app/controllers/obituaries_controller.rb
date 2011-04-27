class ObituariesController < ApplicationController
  # GET /obituaries
  def index
    if params[:range].present?
      @range = params[:range].split(",")
      @range = Time.parse(@range.first)..Time.parse(@range.last)
      with = { :died_on => @range }
    end
    order = params[:sort] == 'name' ? 'last_name ASC, first_name ASC' : nil
    @obituaries = Obituary.search(params[:search],search_options(:with => with, :order => order)).page(params[:page])
  end
end
