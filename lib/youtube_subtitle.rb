require "rexml/document"

class YoutubeSubtitle

  def self.is_youtube_url?(url)
    self.video_id(url) ? true : false
  end

  def self.video_id(url)
    self._youtube_url_regex.match(url) && self._youtube_url_regex.match(url)[1]
  end

  def self.exists?(url)
    if v = YoutubeSubtitle.video_id(url)
      return YoutubeSubtitle.new(v).is_file_exists?
    end
    false
  end

  def self.download(url)
    if v = YoutubeSubtitle.video_id(url)
      return YoutubeSubtitle.new(v).download
    end
    false
  end

  def self.subtitle_lines(url)
    if v = YoutubeSubtitle.video_id(url)
      return YoutubeSubtitle.new(v).get_text_lines
    end
    []
  end

  def self.subtitles(url)
    if v = YoutubeSubtitle.video_id(url)
      return YoutubeSubtitle.new(v).get_subtitles
    end
    []
  end


  def initialize(v, folder_to='subtitles')
    @v         = v
    @folder_to = folder_to
    @lang       = 'en'
    @sub_format = 'ttml'
  end

  def download
p "cmd: #{_get_cmd}"
    system(_get_cmd)
  end

  def is_file_exists?
    File.exists?("#{@folder_to}/#{file_name}")
  end

  def get_cnt
    File.read(file_path)
  end

  # parse xml
  def get_text_lines
    REXML::Document.new(self.get_cnt).root.elements.each('//p/text()') { |u| u }
  end

  def get_subtitles
    ret = []
    lines = REXML::Document.new(self.get_cnt).root.elements.each('//p') { |u| u }
    lines.each do |line|
      ret << {
        text: line.text(),
        begin: _parse_to_sec(line.attribute('begin').value()),
        end:   _parse_to_sec(line.attribute('end').value())
      }
    end
    ret
  end

  # 00:00:02.689 to 2
  def _parse_to_sec(attr)
    hours, minutes, secs = attr.split(':')
    hours.to_f * 60.0 * 60.0 + minutes.to_f * 60.0 + secs.to_f
  end

  def file_path
    "#{@folder_to}/#{file_name}"
  end

  def file_name
    "#{@v}.#{@lang}.#{@sub_format}"
  end

  def _output_path
    "#{@folder_to}/#{@v}"
  end

  # youtube-dl 
  #   -o "HcRcr8m_WPc"
  #   --skip-download 
  #   --write-auto-sub 
  #   --sub-lang en 
  #   --sub-format ttml 
  #   https://www.youtube.com/watch?v=HcRcr8m_WPc
  def _get_cmd
    "youtube-dl -o \"#{_output_path}\" --skip-download --write-auto-sub --sub-lang #{@lang} --sub-format #{@sub_format} \"https://www.youtube.com/watch?v=#{@v}\""
  end

  # source: https://github.com/thibaudgg/video_info/blob/master/lib/video_info/providers/youtube.rb
  def self._youtube_url_regex
    %r{(?:youtube(?:-nocookie)?\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|
       .*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})}x
  end  

end
