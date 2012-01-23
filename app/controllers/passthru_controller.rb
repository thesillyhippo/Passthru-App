class PassthruController < ApplicationController
  def index
    #hostname = "http://www.google.com"
    #hostname = "http://imgur.com"
    #hostname = "http://www.yahoo.com"
    if path_url = params[:path_url]
      p path_url
      path_url = "/" + path_url + "/"
      base_pattern = %r|/(.*?)/(.*)|
      path_url.sub(base_pattern) do |match|
        p match
      end
      p base_pattern =~ path_url
      
      base = Regexp.last_match[1]
      hostname = "http://" + base + ".com"
      
      if extension = Regexp.last_match[2]
        p extension
        extension = "/" + extension
        path_url = "http://" + base + ".com" + extension
        p path_url
      else
        path_url = "http://" + base + ".com"
      end
    else
      path_url = "http://www.google.com"
      hostname = "http://google.com"
      base = "google"
    end
    
      
    @result = RestClient.get(path_url)
    @result = @result.to_str
    @result_duplicate = @result.dup
 
    relative_image_pattern = /<img(.*?)src=['"](.*?)['"](.*?)>/
    
    @result.gsub(relative_image_pattern) do |match|
      p match
      data = Regexp.last_match[2].gsub(/"/,"")
      unless data[0] == 'h' or data[1] == '/'
        url_replacement = hostname + data
        p url_replacement
        @result_duplicate.sub!(data, url_replacement)
      end
    end
    
    @result = @result_duplicate
    @result_duplicate = @result.dup
    
    relative_anchor_pattern = /<a(.*?)href=['"](.*?)['"](.*?)>/
    
    @result.gsub(relative_anchor_pattern) do |match|
      p "ANCHOR"
      p match
      data = Regexp.last_match[2].gsub(/"/, "")
      unless data[0] == 'h' or data[1] == '/'
        url_replacement = base + data
        p url_replacement
        @result_duplicate.sub!(data, url_replacement)
      end
    end
    
    @result = @result_duplicate
    
    ## Absolute
    
    
    # Fix JS/CSS src links
    
    # Fix Anchor links
    ## Relative URLs
    
    
    ### /blog/*
    
    ## /*
    
    
    ## Absolute URLs
    
    ## // URLs
  end

  
  # Fix Images
  ## Relative

end
