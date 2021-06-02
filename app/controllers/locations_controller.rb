require 'http'
require 'json'

class LocationsController < ApplicationController
def venues 
    @category = params[:category]
    @venues = Hash.new
    if categories.include?(@category) 
        get_venues().each do |venue|
            # @location_name = get_location(venue['lat'],venue['lon'])
            # if @location_name == nil
            #     @location_name = create_location(venue['lat'],venue['lon'])
            # @venues[venue['name']] = @location_name
            # end
        end
    end
end

#Return the category of venues
def categorize(venues)
    categories = Set.new
    venues = venues['venues']
    venues.each do |venue|
    filters = filter_category()
    if ! filters.include?(venue['category'])
        categories.add(venue['category'])
    end
    end
    return categories

end

def filter_category
    tags = Set["nightlife","adult","entertainment","sex","beer","wine","whiskey","weed","pork","liquor","spirits","smoke"]
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

def categories
    @Venues = HTTP.get("https://coinmap.org/api/v1/venues/").body.to_s
    @categories = categorize(JSON.parse(@Venues))
    return @categories
end

def get_venues 
    @Venues = HTTP.get("https://coinmap.org/api/v1/venues/").body.to_s
    return JSON.parse(@Venues)['venues']
end

#Return location of place given its latitude and longitude
def Locate(latitude, longitude)
    p latitude
    response = Geocoder.search([latitude,longitude]).first.address
    return response if response.present?
end

def create_location(lat,lon)
    location = Location.create(name: Locate(lat,lon), latitude: lat,longitude: lon)
    return location.name
end

def get_location(lat,long)
    return Location.find_by(latitude:lat, longitude:long)
end

end
