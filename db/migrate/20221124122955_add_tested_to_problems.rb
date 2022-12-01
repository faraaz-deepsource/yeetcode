class AddTestedToProblems < ActiveRecord::Migration[7.0]
  def change
    add_column :problems, :tested, :boolean
  end
end
