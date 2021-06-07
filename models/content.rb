require_relative '../lib/youtube_subtitle'

class Content < Sequel::Model

  one_to_many :words

  def video_id
    YoutubeSubtitle.video_id(url)
  end
  def is_youtube?
    YoutubeSubtitle.is_youtube_url?(url)
  end

  def is_subtitles_exists?
    YoutubeSubtitle.exists?(url)
  end

  def download_subtitles
    YoutubeSubtitle.download(url)
  end

  def subtitles
    YoutubeSubtitle.subtitles(url)
  end

  def subtitle_lines
    YoutubeSubtitle.subtitle_lines(url)
  end

  def words_in_pos
    ret = {}
    self.words.each do |word|
      if word.subtitle_line_pos
        ret[word.subtitle_line_pos] ||= []
        ret[word.subtitle_line_pos] << word
      end
    end
    ret
  end

end
