class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :tagname
      t.belongs_to :Todo_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
