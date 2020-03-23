class RenameCommentsColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :body, :content
  end
end
