class Analytic < ApplicationRecord
  # 関連付け
  belongs_to :content, polymorphic: true
  has_many :views, dependent: :destroy
  
  # バリデーション
  validates :content_id, uniqueness: { scope: :content_type }
  
  # 分析メソッド
  def total_views_count
    views.count
  end
  
  def completed_views_count
    views.where(completed: true).count
  end
  
  def completion_rate
    total = total_views_count
    return 0.0 if total == 0
    (completed_views_count.to_f / total) * 100
  end
  
  def average_view_duration
    return 0 if views.count == 0
    views.average(:duration).to_i
  end
  
  def views_by_device_type
    views.group(:device_type).count
  end
  
  def revenue_per_view
    return 0 if total_views_count == 0
    revenue.to_f / total_views_count
  end
  
  def conversion_rate
    return 0.0 if lead_views == 0
    (conversions.to_f / lead_views) * 100
  end
end
