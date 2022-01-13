class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    restaurant = Restaurant.new(strong_params)
    restaurant.category.downcase!
    if restaurant.save
      redirect_to restaurants_path
    else
      render new_restaurant_path
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  private

  def strong_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end
end
