#!/usr/bin/env ruby
require "date"
require "httparty"
require "trollop"

def format_episode(episode)
  if episode < 10
    "00#{episode}"
  elsif episode < 100
    "0#{episode}"
  else
    episode.to_s
  end
end

def format_url(padded_episode)
  @url_frag.gsub(":ep", padded_episode).gsub(":time_stamp", "#{Time.now.tv_sec}#{Time.now.tv_usec}")
end

def check_args
  Trollop::die :from, "must be non negative" if @opts[:from] < 0
  Trollop::die :to, "must be an integer >= 1" if @opts[:to].blank?
  Trollop::die :to, "must be greater or equal to episode from" if @opts[:to] < @opts[:from]
end

def download
  puts "downloading ruby5 podcasts"

  File.open(@log_filename, "a") do |lf|
    lf.puts "Start downloading ruby5 episodes - #{DateTime.now.to_s}"
    lf.puts "="*10

    (@opts[:from]..@opts[:to]).each do |ep|
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
@opts = Trollop::options do
  opt :from, "Episode from", default: 1, :type => :int
  opt :to, "Episode to", :type => :int
end

check_args
download
