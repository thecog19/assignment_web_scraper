require 'rubygems'
require 'bundler/setup'
require 'mechanize'

# scraper = Mechanize.new
# scraper.history_added = Proc.new { sleep 1.0 }

# https://www.dice.com/jobs?q=job&l=Philadelphia%2C+PA&searchid=1651350807861

# https://www.dice.com/jobs/q-ruby-limit-99-startPage-2-limit-99-jobs?searchid=9637969994242

class Dice < Mechanize
  def initialize(terms, location="")
    @agent = Mechanize.new
    run(terms, location)
  end

  def run(terms, location)
    results = get_page(terms, location)
    render(results)
  end

  def get_page(terms, location)
    results = nil
    @agent.get("https://www.dice.com/jobs?q=#{terms}&l=#{location}") do |page|
      results = page.links_with(id: /position/)
    end
    results
  end

  def render(results)
    results.each do |result|
      p result
    end
    # p results
  end
end

Dice.new("ruby developer")