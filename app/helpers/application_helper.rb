module ApplicationHelper

  def title
    base_title = "Simple App du Tutoriel Ruby on Rails"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def logo
	image_tag("logo.jpg", :alt => "Application exemple", :class => "round")
  end

end

