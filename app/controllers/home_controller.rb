class HomeController < ApplicationController
  before_action :set_areas

  def index
    # @areas=Area.all
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
    @images_galleries=Gallery.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)

  end
  def area
    @areas=Area.all
    @area=Area.find(params[:id])
    @provinces=@area.provinces
    @locations=@area.places.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
    @popular_posts=@area.places.order("view DESC").limit(5)

  end
  def province
    @areas=Area.all
    @province=Province.find(params[:id])
    @area=@province.area
    @provinces=@area.provinces
    @locations=@province.locations.order("created_at DESC").paginate(:page => params[:page], :per_page => 10)
    @popular_posts=@province.locations.order("view DESC").limit(5)

  end
  def location
    @areas=Area.all
    @location=Location.find(params[:id])
    @province=@location.province
    @related_locations=@province.locations.except(@location.id).limit(5)
    @location.update_attribute("view",@location.view.to_i+1)
  end

  def search
    # raise(params[:search])
    @areas=Area.all
    @top_images=Gallery.all
    @last_minutes=Location.all.order("created_at DESC").limit(5)
    @popular_posts=Location.all.order("view DESC").limit(5)

    if params[:search].present?
        @query = Sunspot.search(Province) do
       # @query = Province.solr_search do |s|
         fulltext params[:search]
        #  s.keywords 'a'
      end
      @provinces = @query.results
      raise( @query.hits.to_s)
    else
      @provinces=Province.joins(:locations).order('locations.view DESC').limit(7)
    end
    render 'home/index'
    # redirect_to home_index_path

  end
  def about
    @areas=Area.all
  end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_areas
    # raise('aa')
    @areas = Area.all
    @top_images=Gallery.all

  end
end
