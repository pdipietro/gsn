# encoding: utf-8

class UserProfilePhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  def store_dir
    k = ImageSizes::DESTINATION
    eval(k)
  end
  
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  ImageSizes::CLASSES[:UserProfile][:photo].each do |f|
    k = "process :resize_to_fill => #{ImageSizes::SIZES[f][0]}"
    puts "#{k}"
    version f do
      eval(k)
      #process :convert => ("-resize #{ImageSizes::SIZES[f][0]}")
    end
  end

=begin
// Canvas the same size as the final image
eval("convert -size 36x36 xc:white white.jpg");
// The mask 
eval("convert -size 36x36 xc:none -draw \"fill black circle 18,18 18,18\"  write_mask.png");
// Cut the whole out of the canvas  
eval("composite -compose Dst_Out write_mask.png white.jpg -matte step.png");
// Put the canvas over the image and trim off excess white background   
eval("convert IMG_5745.jpg  step.png -composite -trim final.jpg");
=end
 
=begin
   version :btn do
     process :resize_to_fill => [36, 36]
   end
   version :thumb do
     process :resize_to_fill => [200, 200]
   end
=end
  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  #def filename
  #   "photo.jpg" if original_filename
  #end

end
