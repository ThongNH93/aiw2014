class HomeController < ApplicationController
   before_action :set_areas

  def index
    @areas=Area.all
    @top_images=Gallery.all
    @last_minutes=Location.all.order("created_at DESC").limit(5)
    @popular_posts=Location.all.order("view DESC").limit(5)

    @provinces= Array.new
    @popular_posts.each do |post|
      if !@provinces.include?(post.province)
       @provinces <<  post.province
      end
    end
  end
  def gallery
    # @areas=Area.all
    @images_galleries=Gallery.all
  end
  def area
    # @areas=Area.all
    @area=Area.find(params[:id])
    @provinces=@area.provinces
    @locations=@area.places
  end
  def province
    # @areas=Area.all
    @province=Province.find(params[:id])
    @area=@province.area
    @provinces=@area.provinces
    @locations=@province.locations

  end
  def location
    @areas=Area.all
    @location=Location.find(params[:id])
    @province=@location.province
    @related_locations=@province.locations.except(@location.id).limit(5)
    @location.update_attribute("view",@location.view.to_i+1)
  end

  def image
    # @areas=Area.all
    @image=Gallery.find(params[:id])
  end
  def search
    @query = Province.search do
      fulltext params[:search]
    end
    @provinces = @query.results
  end
  def about
    @areas=Area.all
  end
  private
# Use callbacks to share common setup or constraints between actions.
  def set_areas
    @areas = Area.all
  end
end
