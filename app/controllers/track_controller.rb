require 'uri/http'
require 'nokogiri'
require 'open-uri'

class TrackController < ApplicationController
  
  
  def menu
    #@products = User.find(session[:user_id]).products
  end

  def create
    # TODO: This should probably be done in the model, but this needs to check the url to be tracked to see if it already exists. If it does, only a record in the products_users table needs to be added, not a new product entry

    url = params[:product][:url]
    uri = URI.parse(url)
    domain = PublicSuffix.parse(uri.host) 

    @product = Product.new(:url => url)
    #@product.users << User.find(session[:user_id])
    @product.sale_site = domain.domain

    doc = Nokogiri::HTML(open("#{url}"))
    price = doc.css("span#actualPriceValue")[0].text[1..-1]
    @product.name = doc.css("span#btAsinTitle")[0].text

    p = Price.new

    p.price = price
    @product.prices << p

    if @product.save
      flash[:notice] = "You are now tracking a new product!"
      flash[:flash_class] = "alert alert-success" #need to think about having view changes in the controller 
      redirect_to(:action => "menu")
    else
      flash[:notice] = "We weren't able to track that product, try using another url?"
      flash[:flash_class] = "alert alert-danger"
      @product.errors.full_messages.each do |msg|
        puts msg
      end
      redirect_to(:action => "menu")
    end

  end
end
