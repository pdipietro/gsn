class Image
  include Neo4j::ActiveNode
  include Uuid
  include CreatedAtUpdatedAt

  property  :cloudinary_id, type: String, constraint: :unique

  has_many  :in,  :is_image_of, rel_class: :HasImage, model_class: false
  has_many  :in,  :likes_to, rel_class: :Likes # :any
  has_many  :out, :has_tag, rel_class: :HasTag # Tags

  has_one	  :out, :previous, rel_class: :HasImage, model_class: :Image
end
