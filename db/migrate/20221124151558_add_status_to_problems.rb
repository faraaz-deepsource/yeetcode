class AddStatusToProblems < ActiveRecord::Migration[7.0]
  def change
    add_column :problems, :status, :string
  end
end
