class CreateAnalytics < ActiveRecord::Migration[7.2]
  def change
    create_table :analytics do |t|
      t.references :content, polymorphic: true, null: false
      t.integer :revenue, default: 0
      t.integer :conversions, default: 0
      t.integer :lead_views, default: 0
      t.integer :lead_conversions, default: 0

      t.timestamps
    end
    
    # 同一コンテンツに対して複数の分析データが存在しないようにユニークインデックスを追加
    add_index :analytics, [:content_type, :content_id], unique: true
  end
end
