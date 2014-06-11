module EveCentral
  def number_jumps(from, to)
    url = "http://api.eve-central.com/api/route/from/#{from}/to/#{to}"
    JSON.parse(HTTParty.get(url).body).count
  end

  def hub_distance(system)
    hubs = ["Amarr","Jita","Rens","Dodixie"]
    result = Hash.new
    hubs.each do |hub|
      jumps = number_jumps(system, hub)
      result.store(hub,jumps)
    end
    result
  end
end