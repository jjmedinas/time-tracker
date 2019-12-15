class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :active
      t.datetime :checked_in_at
      t.datetime :checked_out_at

      t.timestamps
    end
  end
end
