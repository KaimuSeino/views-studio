class Work < ApplicationRecord
  # 関連付け
  has_many :episodes, dependent: :destroy
  has_many :short_clips, dependent: :destroy
  has_one :analytic, as: :content, dependent: :destroy
  
  # バリデーション
  validates :title, presence: true
  
  # PostgreSQLの配列型を扱うためのカスタムメソッド
  def tags_array
    self.tags || []
  end
  
  def tags_array=(values)
    self.tags = values
  end
  
  # 分析データを取得または作成するメソッド
  def analytics_data
    self.analytic || create_analytic
  end
end
