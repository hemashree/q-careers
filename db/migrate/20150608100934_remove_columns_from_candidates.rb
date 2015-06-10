class RemoveColumnsFromCandidates < ActiveRecord::Migration
  def change
    remove_column :candidates, :current_country
    remove_column :candidates, :native_country
  end
end
