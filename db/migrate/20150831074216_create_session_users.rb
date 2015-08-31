class CreateSessionUsers < ActiveRecord::Migration
  def change
    create_table :session_users do |t|
      t.belongs_to :session, :session, index: true
      t.belongs_to :user, :user, index: true

      t.timestamps null: false
    end
  end
end
