class CreateRegisteredApp < ActiveRecord::Migration
  def change
    create_table :registered_apps do |t|
      t.string :name
      t.string :url
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
