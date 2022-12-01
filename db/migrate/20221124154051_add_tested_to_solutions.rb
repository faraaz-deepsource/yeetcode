class AddTestedToSolutions < ActiveRecord::Migration[7.0]
  def change
    add_column :solutions, :tested, :boolean
  end
end
