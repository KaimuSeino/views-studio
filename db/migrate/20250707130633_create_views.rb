class CreateViews < ActiveRecord::Migration[7.2]
  def change
    create_table :views do |t|
      t.references :analytic, null: false, foreign_key: true
      t.datetime :timestamp, default: -> { 'CURRENT_TIMESTAMP' }
      t.integer :duration, default: 0  # 視聴時間(秒)
      t.boolean :completed, default: false
      t.string :source
      t.string :ip_address
      t.string :device_type, default: "desktop"  # enum: ['mobile', 'tablet', 'desktop']

      t.timestamps
    end
    
    # 分析データの取得を高速化するためのインデックス
    # belongs_to関連付けで自動的に追加されるので不要
    # add_index :views, :analytic_id
    # タイムスタンプでソートするためのインデックス
    add_index :views, :timestamp
    # デバイスタイプ別の分析を可能にするインデックス
    add_index :views, :device_type
  end
end
