class AddIndexToVideoposts < ActiveRecord::Migration[5.2]
  def change
    add_index :videoposts, [:user_id, :created_at]
  end
end
