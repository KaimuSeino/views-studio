class Episode < ApplicationRecord
  # 関連付け
  belongs_to :work
  has_one :analytic, as: :content, dependent: :destroy
  
  # バリデーション
  validates :title, presence: true
  validates :cloudinary_url, presence: true, if: -> { content_type.present? }
  
  # 定数
  CONTENT_TYPES = ['video', 'image']
  
  # Enum相当のメソッド
  def video?
    content_type == 'video'
  end
  
  def image?
    content_type == 'image'
  end
  
  # 分析データを取得または作成するメソッド
  def analytics_data
    self.analytic || create_analytic
  end
  
  # デュレーションを秒数で取得
  def duration_in_seconds
    return 0 if duration.blank?
    
    # HH:MM:SS形式をパース
    hours, minutes, seconds = duration.split(':').map(&:to_i)
    (hours * 3600) + (minutes * 60) + seconds
  end
end
