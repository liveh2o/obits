module ObituariesHelper

  def decipher_date_range(range)
    min, max = *range
    case
    when max.year > 2010
      content_tag(:strong,"after 2010")
    when min.year < 1930
      content_tag(:strong,"before 1930")
    else
      "from " + content_tag(:strong,"#{min.year}-#{max.year}")
    end
  end

  def decipher_names(last_name,first_name)
    [].tap do |a|
      a << last_name if last_name.present?
      a << first_name if first_name.present?
      a.compact!
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

  def search_text(search)
    text = ''.tap do |str|
      str << content_tag(:strong) do
        %("#{decipher_names(search.last_name_contains,search.first_name_contains).join(", ")}")
      end
      str << ' '
      str << decipher_date_range(search.died_on_between) if search.died_on_between.present?
    end
    text.html_safe
  end

end
