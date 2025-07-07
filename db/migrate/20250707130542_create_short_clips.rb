class CreateShortClips < ActiveRecord::Migration[7.2]
  def change
    create_table :short_clips do |t|
      t.string :title, null: false
      t.string :episode_title
      t.text :description
      t.string :cloudinary_url, null: false
      t.string :cloudinary_public_id
      t.string :content_type, null: false
      t.string :visibility, default: "public"  # enum: ['public', 'private', 'unlisted']
      t.integer :duration, default: 0  # 秒数
      
      # workモデルとの関連付け用
      t.references :work, foreign_key: true, null: true
      
      # タグ情報（配列型）
      t.string :tags, array: true, default: []

      t.timestamps
    end
    
    # クラウディナリーのURLとpublic_idにインデックスを追加
    add_index :short_clips, :cloudinary_url
    add_index :short_clips, :cloudinary_public_id
    # visibilityによる検索高速化のためのインデックス
    add_index :short_clips, :visibility
  end
end
