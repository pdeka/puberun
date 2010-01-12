class BillboardsController < ApplicationController

  before_filter :login_required, :only => [ :new, :edit, :create, :update, :destroy ]
  
  def index
    @billboards = Billboard.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @billboards }
    end
  end

  def show
    @billboard = Billboard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @billboard }
    end
  end

  def new
    @billboard = Billboard.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @billboard }
    end
  end

  def edit
    @billboard = Billboard.find(params[:id])
  end

  def create
    @billboard = Billboard.new(params[:billboard])

    respond_to do |format|
      if @billboard.save
        flash[:notice] = 'Billboard was successfully created.'
        format.html { redirect_to(@billboard) }
        format.xml  { render :xml => @billboard, :status => :created, :location => @billboard }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @billboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @billboard = Billboard.find(params[:id])

    respond_to do |format|
      if @billboard.update_attributes(params[:billboard])
        flash[:notice] = 'Billboard was successfully updated.'
        format.html { redirect_to(@billboard) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @billboard.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @billboard = Billboard.find(params[:id])
    @billboard.destroy

    respond_to do |format|
      format.html { redirect_to(billboards_url) }
      format.xml  { head :ok }
    end
  end
end
