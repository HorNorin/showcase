class Show < ActiveRecord::Base
  validate :check_video

  mount_uploader :video, VideoUploader
  mount_uploader :thumbnail, ThumbnailUploader
  mount_uploader :attachment, AttachmentUploader
  
  validates_presence_of :title, :description

  private

  def check_video
    if new_record?
      if video.url.nil? && youtube_url.nil?
        errors[:video] << "and youtube_url are blank"
      end
    end
    
    if video.url.nil?
      unless youtube_url?(youtube_url)
        errors[:youtube_url] << "is not valid"
      end
    end
    
    if !youtube_url.blank? && !youtube_url?(youtube_url)
      errors[:youtube_url] << "is not valid"
    end
  end

  def youtube_url?(url)
    youtube_id = YouTubeAddy.extract_video_id url
    youtube_id && youtube_id.is_a?(String)
  end
end
