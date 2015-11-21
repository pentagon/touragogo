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
    current_user && current_user.role == 2
  end
end
