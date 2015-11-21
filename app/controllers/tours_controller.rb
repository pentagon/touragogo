class ToursController < ApplicationController
  def index
    attrs = {}
    [:country, :city, :langugage, :date].each do |field|
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
end
