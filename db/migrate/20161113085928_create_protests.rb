class CreateProtests < ActiveRecord::Migration
  def change
    create_table :protests do |t|
      t.string :title
      t.string :description
      t.string :location
      t.datetime :event_date

      t.timestamps null: false
    end
  end
end
