module Ctranslation
  extend ActiveSupport::Concern

  included do 
	 # has_many    :out, :_HAS_TRANSLATION,	model_class: Translation
	end

end
