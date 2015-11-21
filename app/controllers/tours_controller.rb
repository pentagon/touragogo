class ToursController < ApplicationController
  def index
    @tours = Tour.all
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
    Tour.create params[:tour].to_hash
    redirect_to tours_path
  end
end
