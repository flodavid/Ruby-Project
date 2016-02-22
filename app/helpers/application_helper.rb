module ApplicationHelper

  def title
    base_title = "Simple App du Tutoriel Ruby on Rails"
    if @titre.nil?
      base_title
    else
      "#{base_title} | #{@titre}"
    end
  end

end

