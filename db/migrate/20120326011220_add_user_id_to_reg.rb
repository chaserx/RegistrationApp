class AddUserIdToReg < ActiveRecord::Migration
  def change
    add_column :regs, :user_id, :integer

  end
end
