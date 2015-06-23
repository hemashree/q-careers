class AddColumnToCandidates < ActiveRecord::Migration
  def change
  	add_column :candidates, :candidate_type, :string
  	add_column :candidates, :course, :string
  	add_column :candidates, :subject, :string
  	add_column :candidates, :institution, :string
  	add_column :candidates, :communication_addr, :string
  	add_column :candidates, :current_organization, :string
  	add_column :candidates, :current_designation, :string
  end
end
