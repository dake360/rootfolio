module SearchHelper

  # Setups up Google Maps
  # for a div with the id 'google-maps'
  def google_maps!
    return if @google_maps_loaded
    content_for :head, render(:partial => 'shared/map')
    @google_maps_loaded = true
  end
end
