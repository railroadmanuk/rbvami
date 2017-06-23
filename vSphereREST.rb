module VSphereREST

  # Import dependencies
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  module Session
    # Session
    def Session.get_session(hosturi, username, password)
      url = URI(hosturi+'/rest/com/vmware/cis/session')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(url)
      request.basic_auth(username, password)
      request['cookie'] = 'vmware-api-session-id'
      response = http.request(request)
      body = JSON.parse(response.read_body)
      return body['value']
    end
  end

  module Vami
    # VAMI Access
    # Get SSH configuration
    def Vami.get_vami_ssh_config(hosturi, session)
      url = URI(hosturi+'/rest/appliance/access/ssh')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(url)
      request['vmware-api-session-id'] = session
      response = http.request(request)
      body = JSON.parse(response.read_body)
      return body['value']
    end
    # Set SSH configuration
    def Vami.set_vami_ssh_config(hosturi, session, state)
    end
    def Vami.get_vami_shell_config(hosturi, session)
      url = URI(hosturi+'/rest/appliance/access/shell')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(url)
      request['vmware-api-session-id'] = session
      response = http.request(request)
      body = JSON.parse(response.read_body)
      return [ body['enabled'], body['timeout'] ]
    end
    def Vami.get_vami_consolecli_config(hosturi, session)
      url = URI(hosturi+'/rest/appliance/access/consolecli')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(url)
      request['vmware-api-session-id'] = session
      response = http.request(request)
      body = JSON.parse(response.read_body)
      return body['value']
    end
    def Vami.get_vami_dcui_config(hosturi, session)
      url = URI(hosturi+'/rest/appliance/access/consolecli')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(url)
      request['vmware-api-session-id'] = session
      response = http.request(request)
      body = JSON.parse(response.read_body)
      return body['value']
    end
  end
end
