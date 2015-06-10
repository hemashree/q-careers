class AddColumnDescriptionToQcareerConfiguration < ActiveRecord::Migration
  def change
    add_column  :qcareer_configurations, :description, :text
  end
end
