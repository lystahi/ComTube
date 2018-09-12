class AddVideopostsLink < ActiveRecord::Migration[5.2]
  def change
    add_column :videoposts, :link, :text
  end
end
