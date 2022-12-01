class AddStatusToSolutions < ActiveRecord::Migration[7.0]
  def change
    add_column :solutions, :status, :string
  end
end
