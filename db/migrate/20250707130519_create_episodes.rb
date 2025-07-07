class CreateEpisodes < ActiveRecord::Migration[7.2]
  def change
    create_table :episodes do |t|
      t.references :work, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :episode_number
      t.string :content_type, default: "video"  # video または image
      t.string :cloudinary_url
      t.string :thumbnail_url
      t.text :description
      t.boolean :is_paid, default: false
      t.integer :price, default: 0
      t.string :duration, default: "00:00:00"  # hh:mm:ss形式

      t.timestamps
    end
    
    # 作品ごとのエピソード番号で並び替えるためのインデックス
    add_index :episodes, [:work_id, :episode_number]
    # クラウディナリーURLに基づく検索のためのインデックス
    add_index :episodes, :cloudinary_url
  end
end
