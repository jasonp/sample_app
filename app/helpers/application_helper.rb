module ApplicationHelper

	# Return a title on a per-page basis.
	def title
		base_title = "Ruby on Rails Tutorial Sample App"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	
	# Create a logo link for the header partial
	def logo
		logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
	end
	
	
end
