module HomeHelper
  def country_opts_for_select
    Tour.distinct(:country).map do |key|
      label = ISO3166::Country.new(key).to_s.presence || key
      [key, label]
    end
  end

  def city_opts_for_select
    Tour.distinct(:city).map { |key| [key, key] }
  end

  def language_opts_for_select
    Tour.distinct(:language).map do |key|
      label = ISO_639::find(key).try(:english_name) || key
      [key, label]
    end
  end

  def current_user_tourist?
    current_user && current_user.tourist?
  end

  def current_user_guide?
    current_user && current_user.guide?
  end

  def tour_scheduled?(tour)
    current_user && current_user.tour_links.find_by(tour: tour).present?
  end
end
