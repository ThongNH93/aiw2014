class HomeController < ApplicationController
  before_action :set_areas

  def index
    @top_images=TopImage.all.limit(5)
    @last_minutes=Location.all.order("created_at DESC").limit(5)
    @popular_posts=Location.all.order("view DESC").limit(5)
    # raise(@last_minutes.size.to_s )
    # raise(@popular_posts.size.to_s )

    @provinces=Province.joins(:locations).distinct(:province_id).order('locations.view DESC').limit(7)
     # raise(@provinces.first.name)
  end
  def gallery
    @images_galleries=Gallery.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)

  end
  def area
    @area=Area.find(params[:id])
    @provinces=@area.provinces
    @locations=@area.places.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @popular_posts=@area.places.order("view DESC").limit  (5)

  end
  def province
    @province=Province.find(params[:id])
    @area=@province.area
    @provinces=@area.provinces
    @locations=@province.locations.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @popular_posts=@province.locations.order("view DESC").limit(5)

  end
  def location
    @location=Location.find(params[:id])
    @province=@location.province
    @related_locations=@province.locations.except(@location.id).limit(5)
    @location.update_attribute("view",@location.view.to_i+1)

    # raise(@location.created_at.month.to_s)
  end

  def search
    # raise(params[:search])
    @top_images=Gallery.all
    @last_minutes=Location.all.order("created_at DESC").limit(5)
    @popular_posts=Location.all.order("view DESC").limit(5)

    if params[:search].present?
    #      # @query = Sunspot.search(Province) do
    #      @query = Province.search do
    #      fulltext params[:search]
    #   end
    #   @provinces = @query.results

      @provinces=Province.all.where("name LIKE ?","#{params[:search]}%")

    else
      @provinces=Province.joins(:locations).distinct(:province_id).order('locations.view DESC').limit(7)
    end
    render 'home/index'
  end
  def about
  end

  def rss
    @provinces=Province.all
    # raise(Area.find_by_name("NORTHERN VIETNAM").name)
    @north_provinces=Area.find_by_name("NORTHERN VIETNAM").provinces
    @central_provinces=Area.find_by_name("CENTRAL VIETNAM").provinces
    @south_provinces=Area.find_by_name("SOUTHERN VIETNAM").provinces

  end
  def rss_province
    @province=Province.find(params[:id])
    @locations=@province.locations
    render :template => 'home/rss_province.xml.builder', :layout => false
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_areas
    @areas = Area.all
  end
end
