module VsphereREST
  # Import dependencies
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  module Session
    # Session management
    # Create new session
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
    # Delete session
    def Session.delete_session(hosturi, session)
      # foo
    end
  end

  module VamiAccess
    # VAMI Access
    # Get SSH configuration
    def VamiAccess.get_vami_ssh_config(hosturi, session)
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
    def VamiAccess.set_vami_ssh_config(hosturi, session, state)
      # foo
    end
    # Get Shell (bash) configuration
    def VamiAccess.get_vami_shell_config(hosturi, session)
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
    # Set Shell (bash) configuration
    def VamiAccess.set_vami_shell_config(hosturi, session, state)
      # foo
    end
    # Get Console CLI configuration
    def VamiAccess.get_vami_consolecli_config(hosturi, session)
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
    # Set Console CLI configuration
    def VamiAccess.set_vami_consolecli_config(hosturi, session, state)
      # foo
    end
    # Get DCUI configuration
    def VamiAccess.get_vami_dcui_config(hosturi, session)
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
    # Set DCUI configuration
    def VamiAccess.set_vami_dcui_config(hosturi, session, state)
      # foo
    end
  end

  module VamiHealth
    # VAMI Health Status
  end

  module VamiNetworking
    # VAMI Networking
  end
end
