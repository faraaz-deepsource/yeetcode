class AddTitleToProblems < ActiveRecord::Migration[7.0]
  def change
    add_column :problems, :title, :string
    add_column :problems, :description, :text
  end
end
