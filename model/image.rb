require 'rmagick'
require 'tempfile'

class Image
  THUMBNAIL_WIDTH = 600
  SLOT_WIDTH = 20
  TEMPFILE_BASENAME = "image"

  def initialize path
    @path = path
  end

  def resize width
    image = Magick::Image.read(@path).first
    scale = width.to_f / image.columns
    thumbnail_image = image.resize(scale)
    tempfile = Tempfile.new(TEMPFILE_BASENAME)
    thumbnail_image.write(tempfile.path)
    tempfile.read
  end

  def thumbnail_binary
    resize(THUMBNAIL_WIDTH)
  end

  def slot_binary
    resize(SLOT_WIDTH)
  end
end
