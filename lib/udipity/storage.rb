class Udipity::Storage
  include Singleton

  NAMESPACE = 'udipity'
  CLIENT_LIST = 'clients'
  CLIENT_DATA = 'data'

  def store
    @store ||= Redis.new
  end

  def clean_slate
    Udipity::logger.debug "Flushing database..."

    store.del client_list
    store.del client_data
  end

  def add client
    Udipity::logger.info "Adding client #{client.id}"

    store.sadd(client_list, client.id) && ping(client)
  end

  def ping client
    Udipity::logger.debug "Ping from client #{client.id}"

    timestamp = Time.now

    store.hset client_data, client.id,  timestamp

    timestamp
  end

  def check client
    store.sismember(client_list, client.id) 
  end

  def remove client
    id = client.is_a?(Udipity::Client) ? client.id : client
    Udipity::logger.debug "Removing client #{id}"

    store.srem client_list, id
    store.hdel client_data, id
  end

  def timestamp client
    id = client.is_a?(Udipity::Client) ? client.id : client
    store.hget client_data, id
  end

  def list
    items = store.smembers client_list

    clients = items.map do |i|
      time = Time.parse(timestamp i) rescue nil

      if time.nil?
        remove(i) && next
      end

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
