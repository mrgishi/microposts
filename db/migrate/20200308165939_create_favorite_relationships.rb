class CreateFavoriteRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_relationships do |t|
      t.references :user_id
      t.references :micropost_id

      t.timestamps
    end
    #indexを追加
    add_index :favorite_relationships, [:user_id, :micropost_id], unique: true
  end
end