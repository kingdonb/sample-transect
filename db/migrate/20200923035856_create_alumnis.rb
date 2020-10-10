class CreateAlumnis < ActiveRecord::Migration[6.0]
  def change
    create_table :alumnis do |t|
      t.string :first
      t.string :last
      t.string :linkedin_profile
      t.string :graduation_year
      t.string :tags

      t.timestamps
    end
  end
end
