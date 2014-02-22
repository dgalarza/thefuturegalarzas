require 'dotenv'
Dotenv.load

set :haml, { :ugly => true, :format => :html5 }

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :gzip
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'www.thefuturegalarzas.com'
  s3_sync.aws_access_key_id          = ENV['AWS_ACCESS_KEY']
  s3_sync.aws_secret_access_key      = ENV['AWS_SECRET_ACCESS_KEY']
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We chain after the build step by default. This may not be your desired behavior...
  s3_sync.prefer_gzip                = true
  s3_sync.reduced_redundancy_storage = false
end

activate :cloudfront do |cf|
  cf.access_key_id     = ENV['AWS_ACCESS_KEY']
  cf.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
  cf.distribution_id   = ENV['CLOUDFRONT_ID']

  # Asset hash will handle invalidation of assets
  cf.filter = /\.html$/i
end

helpers do
  def gallery_photos
    path = File.expand_path('../source/images/gallery/engagement/thumbs', __FILE__)
    Dir["#{path}/*.jpg"].collect { |thumb_path| thumb_path.gsub(/.+images\//, '') }.shuffle
  end

  def fullsize_gallery_image(image)
    image_path image.gsub('thumbs', 'full')
  end
end
