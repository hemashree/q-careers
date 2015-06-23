class ModifyCareerInterests < ActiveRecord::Migration
  def change
  	add_column :career_interests, :job_id, :integer
  	add_index  :career_interests, :job_id
  	change_column_default(:career_interests, :source, nil)
  end
end
