require 'shellwords'
require 'open3'

module FFMPEGLite
  def write_thumbnail in_file, out_file, seek_time
    result, status = Open3.capture2e("ffmpeg -y -ss #{Shellwords.escape(seek_time.to_s)} -i #{Shellwords.escape(in_file)} -vframes 1 -f image2 #{Shellwords.escape(out_file)}")
  end
end
