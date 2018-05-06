class CreateRequestTrackers < ActiveRecord::Migration[5.2]
  def change
    create_table :request_trackers do |t|
      t.date :date
      t.integer :request_count, default: 0
      t.references :tenant, foreign_key: true

      t.timestamps
    end
  end
end
