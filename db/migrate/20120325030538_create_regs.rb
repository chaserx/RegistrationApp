class CreateRegs < ActiveRecord::Migration
  def change
    create_table :regs do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :organization
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :email
      t.string :status
      t.string :dept
      t.integer :eveningsession, :limit => 1
      t.integer :guest, :limit => 1
      t.integer :partysize
      t.integer :lunch, :limit => 1
      t.string :bizperson
      t.string :bizpersonemail
      t.string :bizpersonphone
      t.decimal :fees, :precision => 6, :scale => 2, :default => 0.0
      t.text :abstracttext
      t.string :abstracttitle
      t.string :abstractauthors

      t.timestamps
    end
  end
end
