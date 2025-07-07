class View < ApplicationRecord
  # 関連付け
  belongs_to :analytic
  
  # バリデーション
  validates :duration, numericality: { greater_than_or_equal_to: 0 }
  validates :device_type, inclusion: { in: ['mobile', 'tablet', 'desktop'] }
  
  # スコープ
  scope :recent, -> { order(timestamp: :desc) }
  scope :completed, -> { where(completed: true) }
  scope :mobile, -> { where(device_type: 'mobile') }
  scope :tablet, -> { where(device_type: 'tablet') }
  scope :desktop, -> { where(device_type: 'desktop') }
  
  # カスタムメソッド
  def watch_time_minutes
    (duration.to_f / 60).round(2)
  end
  
  # コンテンツへのアクセスを簡易化
  def content
    analytic&.content
  end
  
  # デバイスタイプ確認メソッド
  def mobile?
    device_type == 'mobile'
  end
  
  def tablet?
    device_type == 'tablet'
  end
  
  def desktop?
    device_type == 'desktop'
  end
end
