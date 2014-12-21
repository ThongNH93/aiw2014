
xml.instruct! :xml, :version=>"1.0"
xml.rss :version => '2.0' do
  xml.province do
    xml.name @locations.first.province.name
    xml.link home_province_url(@locations.first.province.id)

    @locations.each do |location|
      xml.location do
        xml.name location.name
        xml.province location.province.name
        xml.area  location.province.area.name
        xml.description location.description
        xml.link home_location_url(location)
        xml.image location.image
        xml.author location.author
        xml.pubDate location.created_at.to_s(:rfc822)
      end
    end
  end

end