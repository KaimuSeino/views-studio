class ShortClip < ApplicationRecord
  # 関連付け
  belongs_to :work, optional: true
  
  # バリデーション
  validates :title, presence: true
  validates :cloudinary_url, presence: true
  validates :content_type, presence: true
  validates :visibility, inclusion: { in: ['public', 'private', 'unlisted'] }
  
  # スコープ
  scope :public_clips, -> { where(visibility: 'public') }
  scope :private_clips, -> { where(visibility: 'private') }
  scope :unlisted_clips, -> { where(visibility: 'unlisted') }
  
  # PostgreSQLの配列型を扱うためのカスタムメソッド
  def tags_array
    self.tags || []
  end
  
  def tags_array=(values)
    self.tags = values
  end
  
  # 公開状態の確認メソッド
  def public?
    visibility == 'public'
  end
  
  def private?
    visibility == 'private'
  end
  
  def unlisted?
    visibility == 'unlisted'
  end
  
  # 時間形式を取得
  def formatted_duration
    seconds = duration || 0
    hours = seconds / 3600
    minutes = (seconds / 60) % 60
    seconds = seconds % 60
    format("%02d:%02d:%02d", hours, minutes, seconds)
  end
end
