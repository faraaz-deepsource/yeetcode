class UpdateScoreSolutions < ActiveRecord::Migration[7.0]
  def change
    change_column :solutions, :score, :integer, default: 0
  end
end
