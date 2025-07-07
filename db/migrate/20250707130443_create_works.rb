class CreateWorks < ActiveRecord::Migration[7.2]
  def change
    create_table :works do |t|
      t.string :title, null: false
      t.text :description
      t.string :thumbnail_url, default: ""
      t.string :thumbnail_video_url, default: ""
      t.integer :duration_seconds, default: 0
      t.string :rating
      t.string :release_date
      t.string :cast
      t.string :studio
      
      # PostgreSQLの配列型を使用するためのカラム
      t.string :tags, array: true, default: []

      t.timestamps
    end
    
    # タイトルの検索を高速化するためのインデックス
    add_index :works, :title
  end
end
