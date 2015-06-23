class UpdateDescriptionColumnInQcareerConfiguration < ActiveRecord::Migration
  def change
  	remove_column :qcareer_configurations, :description
    add_column :qcareer_configurations, :description, :string, length: 1024
  end
end
