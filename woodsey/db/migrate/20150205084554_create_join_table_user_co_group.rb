class CreateJoinTableUserCoGroup < ActiveRecord::Migration
  def change
    create_join_table :users, :co_groups do |t|
      t.index [:user_id, :co_group_id]
      t.index [:co_group_id, :user_id]
    end
  end
end
