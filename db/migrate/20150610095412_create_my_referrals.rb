class CreateMyReferrals < ActiveRecord::Migration
  def change
    create_table :my_referrals do |t|
      t.string :name
      t.string :email
      t.boolean :experience
      t.boolean :fresher
      t.string :course
      t.string :subject
      t.string :institution
      t.integer :year_of_passing
      t.string :native_city
      t.string :current_city
      t.string :native_state
      t.string :current_state
      t.text :cummunication_address
      t.string :resume
      t.string :skills
      t.string :job
      t.string :event
      t.string :applicant_relation
      t.string :phone

      t.timestamps null: false
    end
  end
end
