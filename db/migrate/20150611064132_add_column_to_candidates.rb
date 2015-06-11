class AddColumnToCandidates < ActiveRecord::Migration
  def change
  	add_column :candidates, :candidate_type, :string
  end
end
