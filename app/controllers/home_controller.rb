class HomeController < ApplicationController
   # before_action :set_areas

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
    @areas=Area.all
    @images_galleries=Gallery.page(params[:page]).per(2)
  end
  def area
    @areas=Area.all
    @area=Area.find(params[:id])
    @provinces=@area.provinces
    @locations=@area.places.page(params[:page]).per(2)
  end
  def province
    @areas=Area.all
    @province=Province.find(params[:id])
    @area=@province.area
    @provinces=@area.provinces
    @locations=@province.locations.page(params[:page]).per(2)

  end
  def location
    @areas=Area.all
    @location=Location.find(params[:id])
    @province=@location.province
    @related_locations=@province.locations.except(@location.id).limit(4)
    @location.update_attribute("view",@location.view.to_i+1)
  end

  def search
    # raise(params[:search])
    @areas=Area.all
    @top_images=Gallery.all
    @last_minutes=Location.all.order("created_at DESC").limit(5)
    @popular_posts=Location.all.order("view DESC").limit(5)

    if params[:search].present? do
      @query = Province.search
        fulltext params[:search]
      end
      @provinces = @query.results
    else
      @provinces=[]
    end
    render 'home/index'
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
