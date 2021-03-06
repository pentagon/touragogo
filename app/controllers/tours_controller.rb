class ToursController < ApplicationController
  before_action :authenticate_user!, except: [:search]

  def index
    @tours = current_user.tours
  end

  def search
    attrs = {}
    [:country, :language, :date].each do |field|
      attrs[field] = params[field] if params[field].present?
    end
    if attrs[:date].present?
      date = Time.parse attrs[:date]
      attrs[:date] = {
        '$gte' => date.beginning_of_day,
        '$lt' => date.end_of_day,
      }
    end
    @tours = Tour.where(attrs)
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new params[:tour].to_hash.merge(owner: current_user)
    if @tour.save
      redirect_to tour_path(@tour)
    else
      render :new
    end
  end

  def schedule
    current_user.tour_links.create tour: Tour.find(params[:id]), state: 'scheduled'
    redirect_to tours_path
  end

  def show
    @tour = Tour.find(params[:id])
  end
end
