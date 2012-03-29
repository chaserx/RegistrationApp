class AddAbstractToRegs < ActiveRecord::Migration
  def change
    add_column :regs, :abstract, :string

  end
end
