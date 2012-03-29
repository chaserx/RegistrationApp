class RegsController < ApplicationController
  before_filter :authenticate_user!

  require 'csv'
  #require 'zipruby'
  require 'zip/zipfilesystem'
  require 'open-uri'
  require 'tempfile'
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
              csv << ["Name", "Dept.", "Org.", "Address1", "Address2", "City", "State", "Zip", "Phone", "email", "Lunch", "EveningSession", "Partysize", "Fees", "BusinessOfficer", "BizOfficerEmail", "BizOfficerPhone", "Date Registered"]
              registrations.each do |registration|
                csv << [[registration.title, registration.firstname, registration.lastname].join(" ").strip, registration.dept, registration.organization, registration.address1, registration.address2, registration.city, registration.state, registration.zip, registration.phone, registration.email, registration.lunch, registration.eveningsession, registration.partysize, registration.fees, registration.bizperson, registration.bizpersonemail, registration.bizpersonphone, registration.created_at ]
              end
            end
            t = Time.now
            send_data(csv, :filename => "Registrations#{t.strftime("%m_%d_%Y")}.csv", 
                      :type => 'text/csv', :disposition => 'attachment')
      }
      format.zip {
                     #registrations_with_attachments = Registration.find_by_sql('SELECT * FROM registrations WHERE abstract_file_name NOT LIKE ""')
                     registrations_with_attachments = Reg.find(:all, :conditions => "abstract IS NOT NULL")
                     
                     if registrations_with_attachments.size > 0
                       
                       headers['Cache-Control'] = 'no-cache'  
                       tmp_filename = "#{Rails.root.to_s}/tmp/tmp_zip_" <<
                                     Time.now.to_f.to_s <<
                                     ".zip"

                       # zipruby gem
                       #Zip::Archive.open(tmp_filename, Zip::CREATE) do |zip|
                       Zip::ZipFile.open(tmp_filename, Zip::ZipFile::CREATE) do |zip|
                       #get all of the attachments

                       # attempt to get files stored on S3
                       # apparently works thanks to Vlad Romascanu;       
                       # http://stackoverflow.com/questions/2338758/zip-up-all-paperclip-attachments-stored-on-s3
                          registrations_with_attachments.each { |e| 
                            tempfile = Tempfile.new("#{Rails.root}/tmp/myfile_#{Process.pid}",'w')
                            tempfile.binmode
                            open(e.abstract_url}) {|f| tempfile.write f.read }
                            zip.file.open(tempfile, "w")
                            tempfile.close
                            tempfile.unlink
                          }
                          #registrations_with_attachments.each { |e| zip.add_file("abstracts/#{e.abstract}", open(e.abstract_url) {|f| f.read}) }
                       # => No such file or directory - http://s3.amazonaws.com/bucket/original/abstract.txt
                       # Should note that these files in S3 bucket are publicly accessible. No ACL. 

                       # works with local storage. Thanks to Henrik Nyh
                       # registrations_with_attachments.each { |e| zip.add("abstracts/#{e.abstract.original_filename}", e.abstract.path(:original))   }
                       end

                       send_data(File.open(tmp_filename, "rb+").read, :type => 'application/zip', :disposition => 'attachment', :filename => tmp_filename.to_s)
                       File.delete tmp_filename
                       
                    else
                        redirect_to regs_path, :notice => "No attachments to zip up"
                    end
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
    @reg.user_id = current_user.id
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
