require 'rmagick'
require 'tempfile'

class Image
  THUMBNAIL_WIDTH = 600
  TEMPFILE_BASENAME = "image"

  def initialize path
    @path = path
  end

  def thumbnail_binary
    image = Magick::Image.read(@path).first
    scale = THUMBNAIL_WIDTH.to_f / image.columns
    thumbnail_image = image.resize(scale)
    tempfile = Tempfile.new(TEMPFILE_BASENAME)
    thumbnail_image.write(tempfile.path)
    tempfile.read
  end
end
