class CreateCoGroups < ActiveRecord::Migration
  def change
    create_table :co_groups do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
