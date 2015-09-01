class AddForgotDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :forgot_digest, :string
  end
end
