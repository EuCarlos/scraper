require 'nokogiri'
require 'httparty'

def main
    response = 'http://localhost:5500/news/'
    unparsed_page = HTTParty.get(response)
    parsed_page = Nokogiri::HTML(unparsed_page.body)

    jobs = Array.new
    job_listings = parsed_page.css('div.magazine-layout')
    job_listings.each_with_index do |job_listing, index|
        jobs.push({
            id: index,
            title: job_listing.css('a.article-link')[index].text,
            url: "#{response}#{job_listing.css('a')[index].attributes['href'].value}"
        })
    end
    message = "#{job_listings.count} news were found"
    message.gsub!('news', 'new') if job_listings.count == 1
    puts message

    File.write("tmp/news.json", jobs.to_json)
end

main