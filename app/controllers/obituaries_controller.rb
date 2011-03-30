class ObituariesController < ApplicationController
  # GET /obituaries
  # GET /obituaries.xml
  def index
    @obituaries = Obituary.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @obituaries }
    end
  end

  # GET /obituaries/1
  # GET /obituaries/1.xml
  def show
    @obituary = Obituary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @obituary }
    end
  end

  # GET /obituaries/new
  # GET /obituaries/new.xml
  def new
    @obituary = Obituary.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @obituary }
    end
  end

  # GET /obituaries/1/edit
  def edit
    @obituary = Obituary.find(params[:id])
  end

  # POST /obituaries
  # POST /obituaries.xml
  def create
    @obituary = Obituary.new(params[:obituary])

    respond_to do |format|
      if @obituary.save
        format.html { redirect_to(@obituary, :notice => 'Obituary was successfully created.') }
        format.xml  { render :xml => @obituary, :status => :created, :location => @obituary }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @obituary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /obituaries/1
  # PUT /obituaries/1.xml
  def update
    @obituary = Obituary.find(params[:id])

    respond_to do |format|
      if @obituary.update_attributes(params[:obituary])
        format.html { redirect_to(@obituary, :notice => 'Obituary was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @obituary.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /obituaries/1
  # DELETE /obituaries/1.xml
  def destroy
    @obituary = Obituary.find(params[:id])
    @obituary.destroy

    respond_to do |format|
      format.html { redirect_to(obituaries_url) }
      format.xml  { head :ok }
    end
  end
end
