class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    # 10.1
    add_index :microposts, [:user_id, :created_at]
  end
end
