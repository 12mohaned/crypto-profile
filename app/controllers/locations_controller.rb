require 'http'
require 'json'

class LocationsController < ApplicationController
def venues 
    category = params[:category]
    @venues = []
    if get_categories.include?(category)
        get_venues().each do |venue|
            venue['category'].eql?(category) ? @venues.push(venue) : @venues
        end
    end
end

#Return the category of venues
def categorize(venues)
    categories = Set.new
    venues = venues['venues']
    venues.each do |venue|
    filters = filter_category()
    if ! filters.include?(venue['category']) & filter(venue['name'])
        categories.add(venue['category'])
    end
    end
    return categories

end

#Return location of place given its latitude and longitude
def getLocation(latitude, longitude)
    lat = "latitude"
    lon = "longitude"
    lat_lon = "#{latitude},#{longitude}"
    response = Geocoder.search(lat_lon).first
    return response.city if response.present?
end

def filter_category
    tags = Set["nightlife","adult","entertainment","sex","beer","wine","whiskey","weed","pork"]
    return tags
    end

#filter venues names according to filter set
def filter(name)
    filter_category().each do |filter|
        if name.downcase.include?filter
            return false
        end
    end
    return true
end

def get_categories
    @Venues = HTTP.get("https://coinmap.org/api/v1/venues/").body.to_s
    @categories = categorize(JSON.parse(@Venues))
    return @categories
end

def get_venues 
    @Venues = HTTP.get("https://coinmap.org/api/v1/venues/").body.to_s
    return JSON.parse(@Venues)['venues']
    end

end

