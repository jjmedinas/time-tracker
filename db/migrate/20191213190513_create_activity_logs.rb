class CreateActivityLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :active
      t.datetime :checkin
      t.datetime :checkout

      t.timestamps
    end
  end
end
