module EveCentral

  def fetch_jumps(system)
    system = system_type(params[:system].to_s)
    hub_distance(system)
  rescue JSON::ParserError
    return "Please enter a valid system"
  rescue SocketError
    return "Unable to Connect to EveCentral"
  end

  def system_type(system) 
      system.match(/-/) != nil ? system.upcase : system.titleize
  end

  def query_ec(from, to)
    url = URI.escape("http://api.eve-central.com/api/route/from/#{from}/to/#{to}")
    JSON.parse(HTTParty.get(url).body).count
  end

  def hub_distance(system)
    hubs = ["Amarr","Jita","Rens","Dodixie"]
    result = Hash.new
    hubs.each do |hub|
      jumps = query_ec(system, hub)
      result.store(hub,jumps)
    end
    result
  end
end