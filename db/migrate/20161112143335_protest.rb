class Protest < ActiveRecord::Migration
  def change
      create_table "protests", force: :cascade do |t|
        t.string   "title"
        t.string   "location"
        t.string   "description"
        t.datetime "event_date"
      end
  end
end
