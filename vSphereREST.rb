module VSphereREST
  # Import dependencies
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  def VSphereREST.get_session(hosturi, username, password)
    url = URI(hosturi+"/rest/com/vmware/cis/session")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(url)
    request.basic_auth(username, password)
    request["cookie"] = 'vmware-api-session-id'
    response = http.request(request)
    token = JSON.parse(response.read_body)
    return token['value']
  end

  def VSphereREST.get_vami_ssh_config(hosturi, session)
    return 'ENABLED'
  end
end
