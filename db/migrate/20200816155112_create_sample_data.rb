class CreateSampleData < ActiveRecord::Migration[6.0]
  def change
    create_table :sample_data do |t|

      t.timestamps
    end
  end
end
