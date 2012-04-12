class EmailannouncementsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorized?

  # GET /emailannouncements
  # GET /emailannouncements.json
  def index
    @emailannouncements = Emailannouncement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @emailannouncements }
    end
  end

  # GET /emailannouncements/1
  # GET /emailannouncements/1.json
  def show
    @emailannouncement = Emailannouncement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @emailannouncement }
    end
  end

  # GET /emailannouncements/new
  # GET /emailannouncements/new.json
  def new
    @emailannouncement = Emailannouncement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @emailannouncement }
    end
  end

  # GET /emailannouncements/1/edit
  def edit
    @emailannouncement = Emailannouncement.find(params[:id])
  end

  # POST /emailannouncements
  # POST /emailannouncements.json
  def create
    @emailannouncement = Emailannouncement.new(params[:emailannouncement])

    respond_to do |format|
      if @emailannouncement.save
        format.html { redirect_to @emailannouncement, notice: 'Emailannouncement was successfully created.' }
        format.json { render json: @emailannouncement, status: :created, location: @emailannouncement }
        RegMailer.contact_registrants(@emailannouncement).deliver
      else
        format.html { render action: "new" }
        format.json { render json: @emailannouncement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /emailannouncements/1
  # PUT /emailannouncements/1.json
  def update
    @emailannouncement = Emailannouncement.find(params[:id])

    respond_to do |format|
      if @emailannouncement.update_attributes(params[:emailannouncement])
        format.html { redirect_to @emailannouncement, notice: 'Emailannouncement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @emailannouncement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emailannouncements/1
  # DELETE /emailannouncements/1.json
  def destroy
    @emailannouncement = Emailannouncement.find(params[:id])
    @emailannouncement.destroy

    respond_to do |format|
      format.html { redirect_to emailannouncements_url }
      format.json { head :no_content }
    end
  end

  protected
  def authorized?
      redirect_to user_root_url unless current_user.admin?
  end
end
