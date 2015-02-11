class CreateProgramSteps < ActiveRecord::Migration
  def change
    create_table :program_steps do |t|
      t.integer :order
      t.integer :duration
      t.text :description, :limit => 4294967295
      t.text :materials, :limit => 4294967295
      t.text :notes, :limit => 4294967295
      
      t.belongs_to :program, index: true

      t.timestamps null: false
    end
    add_foreign_key :program_steps, :programs
  end
end
