class AddLangToProblems < ActiveRecord::Migration[7.0]
  def change
    add_column :problems, :lang, :string
    add_column :problems, :test, :text
  end
end
