class RegsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorized?, :only => [:index, :destroy]

  before_filter :is_reg_open?, :only => [:new]

  require 'csv'
  
  # GET /regs
  # GET /regs.json
  def index
    @regs = Reg.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regs }
      format.csv {
            registrations = Reg.order("lastname ASC").all
            csv = CSV.generate do |csv|
              csv << ["Name", "Dept.", "Org.", "Address1", "Address2", "City", "State", "Zip", "Phone", "Email", "Lunch", "EveningSession", "Partysize", "Fees", "BusinessOfficer", "BizOfficerEmail", "BizOfficerPhone", "Date Registered"]
              registrations.each do |registration|
                csv << [[registration.title, registration.firstname, registration.lastname].join(" ").strip, registration.dept, registration.organization, registration.address1, registration.address2, registration.city, registration.state, registration.zip, registration.phone, registration.email, registration.lunch, registration.eveningsession, registration.partysize, registration.fees, registration.bizperson, registration.bizpersonemail, registration.bizpersonphone, registration.created_at ]
              end
            end
            t = Time.now
            send_data(csv, :filename => "Registrations#{t.strftime("%m_%d_%Y")}.csv", 
                      :type => 'text/csv', :disposition => 'attachment')
      }
    end
  end

  # GET /regs/1
  # GET /regs/1.json
  def show
    @reg = Reg.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reg }
    end
  end

  # GET /regs/new
  # GET /regs/new.json
  def new
    @reg = Reg.new :email => current_user.email, :organization => "University of Kentucky"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reg }
    end
  end

  # GET /regs/1/edit
  def edit
    @reg = Reg.find(params[:id])
  end

  # POST /regs
  # POST /regs.json
  def create
    @reg = Reg.new(params[:reg])
    @reg.user_id = current_user.id
    respond_to do |format|
      if @reg.save
        format.html { redirect_to @reg, notice: 'Reg was successfully created.' }
        format.json { render json: @reg, status: :created, location: @reg }
        RegMailer.reg_receipt(@reg).deliver
      else
        format.html { render action: "new" }
        format.json { render json: @reg.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /regs/1
  # PUT /regs/1.json
  def update
    @reg = Reg.find(params[:id])

    respond_to do |format|
      if @reg.update_attributes(params[:reg])
        format.html { redirect_to @reg, notice: 'Reg was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reg.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regs/1
  # DELETE /regs/1.json
  def destroy
    @reg = Reg.find(params[:id])
    @reg.destroy

    respond_to do |format|
      format.html { redirect_to regs_url }
      format.json { head :no_content }
    end
  end

  protected
  def authorized?
      redirect_to user_root_url unless current_user.admin?
  end

  def is_reg_open?
    unless Setting.first.reg_available?
      redirect_to user_root_path, :alert => 'Sorry, symposium registration is closed.'
    end
  end
end
