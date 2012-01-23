class BlogController < ApplicationController
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
      p "begin"
      p Regexp.last_match[0]
      p "1"
      p Regexp.last_match[1]
      p "2"
      p Regexp.last_match[2]
      
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
  # if @result_string.include?("img")
  #   start = 0
  #   while @img_index = @result_string.index("img", start)
  #     @src_index = @result_string.index("src", @img_index)
  #     @url_begin = @result_string.index("'", @src_index)
  #     @url_end = @result_string.index("'", @url_begin + 1)
  #     @src_url = @result_string[@url_begin, @url_end + 1]
  #     unless @src_url[0] == 'h'
  #       
  #     end
  #   end
  # end
  
  # Fix Images
  ## Relative

end
