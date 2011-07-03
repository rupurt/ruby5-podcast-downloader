#!/usr/bin/env ruby
require "date"
require "httparty"

def format_episode(episode)
  if episode < 10
    "00#{episode}"
  elsif episode
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

  File.open(@log_filename, "a") do |lf|
    lf.puts "Start downloading ruby5 episodes - #{DateTime.now.to_s}"
    lf.puts "="*10

    (@ep_from..@ep_to).each do |ep|
      ep_str = format_episode(ep)
      url = format_url(ep_str)

      puts "starting episode #{ep_str} - #{url}"
      response = HTTParty.get(url)
      if response.code == 200
        File.open(@out_filename.gsub(":ep", ep_str), "wb") { |f| f.write(response) }
        puts "download complete"
        lf.puts "episode #{ep_str}.mp3 successfully downloaded"
      elsif
        puts "download not completed - code #{response.code}"
        lf.puts "error downloading episode #{ep_str}.mp3"
      end
      puts "#{"-"*10}#{("\n")*2}"
    end

    lf.puts "Finished downloading ruby5 episodes - #{DateTime.now.to_s}"
    lf.puts "-"*10
    lf.puts "\n"*2
  end
end

@url_frag = "http://media.ruby5.envylabs.com/sites/0001/episodes/:ep-ruby5.mp3?:time_stamp"
@out_filename = "episodes/:ep-ruby5.mp3"
@log_filename = "log.txt"
@ep_from = 1
@ep_to = 146

download
