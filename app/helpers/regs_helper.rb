module RegsHelper
	def firstname_and_lastname(e)
    	"#{e.firstname} #{e.lastname}"
  	end

  	def number_of_attendees
    return Reg.count
  end
  
  def number_of_attendees_for_lunch
    #return Reg.find(:all, :conditions => "lunch = '1'").size
    return Reg.count(:conditions => 'lunch IS true')
  end
  
  # def number_of_attendees_for_dinner
  #   total = 0
  #   registrations = Reg.find(:all)
  #   registrations.each{|e| total += e.partysize}
  #   return total
  # end

  def number_of_attendees_for_dinner
    return Reg.count(:conditions => 'eveningsession IS true') + Reg.count(:conditions => 'guest IS true')
  end
  
  def number_of_abstracts
    total = 0
    # return Registration.find_by_sql('SELECT * FROM registrations WHERE abstract_file_name NOT LIKE ""').size
    # return Reg.find(:all, :conditions => "abstract IS NOT NULL").size
    return Reg.count(:conditions => "abstract IS NOT NULL")
  end
  
  def dollars_pledged
    total = 0
    return Reg.sum('fees')
  end
  
  def hasFees(reg)
    if reg.fees > 0
      return "#{number_to_currency(reg.fees)},"
    else "No Fees,"
    end
    rescue "Unknown Fees,"
  end

  def hasEveningSession(reg)
    if reg.eveningsession?
      return "Evening Session,"
    else "No Evening Session,"
    end 
    rescue "Unknown Evening Session,"
  end
  
  def hasLunch(reg)
    if reg.lunch?
      return "Lunch"  
    else "No Lunch"
    end
    rescue "Unknown Lunch"
  end
  
  def singleOrCompany(reg)
    if reg.eveningsession?
      case
        when reg.partysize == 1
          return "Single for"
        when reg.partysize > 1
          return "Party of #{reg.partysize} for"
      end
    end
    rescue "Unknown Party Size for"
  end
  
  def going_esession?(arr)
    if arr.eveningsession?
    	render :inline => "Yes"
    else
      render :inline => "No"
    end
  end
  
  def going_lunch?(arr)
    if arr.lunch?
    	render :inline => "Yes"
    else
      render :inline => "No"
    end
  end
  
  def latest_attendee
      @reg = Reg.find(:last, :order => 'created_at ASC')
      unless @reg.nil?
        return "#{@reg.firstname} #{@reg.lastname} - #{time_ago_in_words(@reg.created_at)} ago"
      end
  end
  
  def format_phone(reg)
    ph = reg
    if ph.size == 10
      return "(#{ph[0..2]}) #{ph[3..5]} - #{ph[6..9]}"
    elsif ph.size == 5
      return "#{ph.first}-#{ph[1..4]}"
    elsif ph.size == 7
      return "#{ph[0..2]} - #{ph[3..6]}"
    else
      return ph
    end
    
  end
  
  #for show action
  def prettyNameFormat
    return @reg.title + " " + @reg.firstname + " " + @reg.lastname
  end
  
  def getAbstract(arg)
  		return link_to("#{arg.abstract_url}", arg.abstract_url) 
      #return arg.abstract.value
  end
  
  def format_name(reg)
    return reg.title + " " + reg.firstname + " " + reg.lastname
  end
  
  # def is_reg_open?
  #   unless Setting.first.reg_available?
  #     render :partial => 'open_button'
  #   else
  #     ""
  #   end
  # end

end
