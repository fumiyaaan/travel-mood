class CreateSpots < ActiveRecord::Migration[6.0]
  def change
    create_table :spots do |t|
      t.string     :title,       null: false
      t.text       :description, null: false
      t.references :user,        foreign_key: true
      t.timestamps
    end
  end
end
