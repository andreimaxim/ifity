class Udipity::Storage
  include Singleton

  NAMESPACE = 'udipity'
  CLIENT_LIST = 'clients'
  CLIENT_DATA = 'data'

  def store
    @store ||= Redis.new(url: Udipity.configuration.redis_url)
  end

  def clean_slate
    Udipity.logger.debug "Flushing database..."

    store.del client_list
    store.del client_data
  end

  def add client
    Udipity.logger.debug "Adding client #{client.id}"

    store.sadd(client_list, client.id) && ping(client)
  end

  def ping client
    Udipity.logger.debug "Ping from client #{client.id}"

    timestamp = Time.now.to_f
    store.hset client_data, client.id,  timestamp

    timestamp
  end

  def check client
    store.sismember(client_list, client.id) 
  end

  def remove client
    id = client.is_a?(Udipity::Client) ? client.id : client
    Udipity.logger.debug "Removing client #{id}"

    store.srem client_list, id
    store.hdel client_data, id
  end

  def timestamp client
    id = client.is_a?(Udipity::Client) ? client.id : client
    store.hget(client_data, id).to_f
  end

  def clients
    items = store.smembers client_list
    data = store.hgetall(client_data).to_h
  
    clients = items.map do |i|
      time = Time.at(data[i].to_f) rescue Time.at(0)

      Udipity::Client.new i, timestamp: time
    end

    clients.compact
  end

  private
  def client_list
    "#{NAMESPACE}:#{CLIENT_LIST}"
  end

  def client_data
    "#{NAMESPACE}:#{CLIENT_DATA}"
  end
end
