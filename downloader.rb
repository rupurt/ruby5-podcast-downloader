#!/usr/bin/env ruby
require "date"
require "httparty"

def format_episode(episode)
  if episode < 10
    "00#{episode}"
  elsif ep
    "0#{episode}"
  else
    episode.to_s
  end
end

def format_url(padded_episode)
  @url_frag.gsub(":ep", padded_episode).gsub(":time_stamp", "#{Time.now.tv_sec}#{Time.now.tv_usec}")
end

def download
  puts "downloading ruby5 podcasts"

  (@ep_from..@ep_to).each do |ep|
    ep_str = format_episode(ep)
    url = format_url(ep_str)

    puts "starting episode #{ep_str} - #{url}"
    response = HTTParty.get(url)
    if response.code == 200
      puts "download complete"
    elsif
      puts "download not completed - code #{response.code}"
    end
    puts "------------#{("\n")*2}"
  end
end

@url_frag = "http://media.ruby5.envylabs.com/sites/0001/episodes/:ep-ruby5.mp3?:time_stamp"
@ep_from = 1
@ep_to = 146

download
