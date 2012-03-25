class RegsController < ApplicationController
  # GET /regs
  # GET /regs.json
  def index
    @regs = Reg.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regs }
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
    @reg = Reg.new

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

    respond_to do |format|
      if @reg.save
        format.html { redirect_to @reg, notice: 'Reg was successfully created.' }
        format.json { render json: @reg, status: :created, location: @reg }
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
end
