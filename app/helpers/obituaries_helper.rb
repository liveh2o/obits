module ObituariesHelper

  def decipher_date_range(range)
    min, max = range.first, range.last
    case
    when max.year > 2010
      content_tag(:strong,"after 2010")
    when min.year < 1930
      content_tag(:strong,"before 1930")
    else
      "from " + content_tag(:strong,"#{min.year}-#{max.year}")
    end
  end

  def options_for_date_range(value)
    options = []
    decade = Date.today.year - Date.today.year % 10
    
    options << ["After #{decade}","#{decade}-01-01,#{Date.today.to_s}"]
    until decade == 1930 do
      decade -= 10
      options << ["#{decade}-#{decade + 9}","#{decade}-01-01,#{decade + 9}-12-31"]
    end
    options << ["Before 1930","#{Obituary.minimum(:died_on).to_s},1929-12-31"]

    options_for_select(options,value)
  end

  def search_text(search,range)
    text = [].tap do |a|
      a << content_tag(:strong,%("#{search}")) if search.present?
      a << decipher_date_range(range) if range.present?
    end
    text.join(' ').html_safe
  end

end
