class CreateClicks < ActiveRecord::Migration[6.0]
  def change
    create_table :clicks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :path
      t.integer :amount_clicks
    end
  end
end
