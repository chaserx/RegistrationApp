class BigMigration < ActiveRecord::Migration
  def change
  	  create_table "regs", :force => true do |t|
	    t.string   "title"
	    t.string   "firstname"
	    t.string   "lastname"
	    t.string   "organization"
	    t.string   "address1"
	    t.string   "address2"
	    t.string   "city"
	    t.string   "state"
	    t.string   "zip"
	    t.string   "phone"
	    t.string   "email"
	    t.string   "status"
	    t.string   "dept"
	    t.boolean  "eveningsession",                                :default => false
	    t.boolean  "guest",                                         :default => false
	    t.integer  "partysize"
	    t.boolean  "lunch",                                         :default => false
	    t.string   "bizperson"
	    t.string   "bizpersonemail"
	    t.string   "bizpersonphone"
	    t.decimal  "fees",            :precision => 6, :scale => 2, :default => 0.0
	    t.text     "abstracttext"
	    t.string   "abstracttitle"
	    t.string   "abstractauthors"
	    t.datetime "created_at",                                                       :null => false
	    t.datetime "updated_at",                                                       :null => false
	    t.string   "abstract"
	    t.integer  "user_id"
	  end

	  create_table "settings", :force => true do |t|
	    t.boolean  "reg_available", default => true
	    t.datetime "dtstart"
	    t.datetime "dtend"
	    t.integer  "max_capacity"
	    t.datetime "created_at",    :null => false
	    t.datetime "updated_at",    :null => false
	  end

	  create_table "users", :force => true do |t|
	    t.string   "email",                  :default => "",    :null => false
	    t.string   "encrypted_password",     :default => "",    :null => false
	    t.string   "reset_password_token"
	    t.datetime "reset_password_sent_at"
	    t.datetime "remember_created_at"
	    t.integer  "sign_in_count",          :default => 0
	    t.datetime "current_sign_in_at"
	    t.datetime "last_sign_in_at"
	    t.string   "current_sign_in_ip"
	    t.string   "last_sign_in_ip"
	    t.datetime "created_at",                                :null => false
	    t.datetime "updated_at",                                :null => false
	    t.boolean  "admin",                  :default => false
	  end

	  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
	  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  	
  end

end
