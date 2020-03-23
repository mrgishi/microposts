class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user
      t.references :micropost
      t.string :body

      t.timestamps
    end
    add_index :comments , [:user_id, :micropost_id, :created_at]
  end
end
