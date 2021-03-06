require 'RMagick'
require 'tempfile'
require 'shellwords'
require_relative '../config'

class Image
  THUMBNAIL_WIDTH = 600
  SLOT_WIDTH = 60
  TEMPFILE_BASENAME = "image"
  @@size_cache = {}

  def initialize dirname, filename
    @path = [ CONFIG["DATA_DIR"], dirname, filename ].join("/")
  end

  def resize width
    image = Magick::Image.read(@path).first
    scale = width.to_f / image.columns
    thumbnail_image = image.resize(scale)
    tempfile = Tempfile.new(TEMPFILE_BASENAME)
    thumbnail_image.write(tempfile.path)
    image.destroy!
    thumbnail_image.destroy!
    tempfile.read
  end

  def thumbnail_binary
    resize(THUMBNAIL_WIDTH)
  end

  def slot_binary
    resize(SLOT_WIDTH)
  end

  def size
    w, h = `identify -format "%w %h" "#{@path}"`.split(" ").map(&:to_i)
    { :width => w, :height => h }
  end

  def self.sizes arr
    path = arr.map{|image| image.path}
    key = path.join(",")
    return @@size_cache[key] if @@size_cache[key]
    escaped_path = path.map{|i| Shellwords.escape(i) }
    value = `identify -format "%w %h\n" #{escaped_path.join(' ')}`
      .split("\n").map{|line| line.split(" ").map(&:to_i)}
      .map{|w, h| { :width => w, :height => h} }
    @@size_cache[key] = value
    value
  end

  attr_reader :path
end
