class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.integer :status
      t.string :title
      t.text :outcome, :limit => 16777215
      t.text :indicators, :limit => 4294967295

      t.belongs_to :co_group, index: true

      t.timestamps null: false
    end
  end
end
