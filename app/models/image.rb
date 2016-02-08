class Image 
  include Neo4j::ActiveNode
  include Uuid
  include CreatedAtUpdatedAt

  has_many  :in,  :is_image_of, rel_class: :HasImage
  has_many  :out, :has_tag, rel_class: :HasTag # Tags

  has_one	  :out, :has_old_version, rel_class: :HasImage
end
