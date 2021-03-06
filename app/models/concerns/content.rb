module Content
  extend ActiveSupport::Concern

  included do 
		property    :content, type: String

		validates 	:content, :presence => true, length: { minimum: 6 }
	end
end
