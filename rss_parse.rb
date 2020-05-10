#!/usr/bin/env ruby

require 'rss'
require 'open-uri'
require 'reverse_markdown'

  url = 'https://newsfeed.eveonline.com/en-US/42/articles' #/page/1/20'
  URI.open(url) do |rss|
    feed = RSS::Parser.parse(rss)
    feed.items.each do |item|
      title = item.title.content
      author = item.author.name.content
      published = item.published.content
      link = item.link.href
      content = ReverseMarkdown.convert(item.content.content)
      adjusted_publish = published.to_s.gsub(/[-T:Z]/,"")
      File.open("news/#{adjusted_publish}.md", "w") do |file|
        file.puts "# #{title}"
        file.puts "By #{author}"
        file.puts "Published on #{link} at #{published}"
        file.puts ""
        file.puts content
      end
    end
  end
