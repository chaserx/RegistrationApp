class AddSubjectToEmailannouncements < ActiveRecord::Migration
  def change
    add_column :emailannouncements, :subject, :string

  end
end
