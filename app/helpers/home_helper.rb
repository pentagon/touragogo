module HomeHelper
  def country_opts_for_select
    Tour.distinct(:country).map { |c| [c, c] }
  end

  def city_opts_for_select
    Tour.distinct(:city).map { |c| [c, c] }
  end

  def language_opts_for_select
    Tour.distinct(:language).map { |c| [c, c] }
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
