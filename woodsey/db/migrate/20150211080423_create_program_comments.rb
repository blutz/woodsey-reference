class CreateProgramComments < ActiveRecord::Migration
  def change
    create_table :program_comments do |t|
      t.belongs_to :program, index: true
      t.references :user
      t.text :comment, :length => 16777215

      t.timestamps null: false
    end
    add_foreign_key :program_comments, :users
    add_foreign_key :program_comments, :programs
  end
end
