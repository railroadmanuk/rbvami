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

  module Vami
    module Access
      # VAMI Access
      # Get SSH configuration
      def Access.get_vami_ssh_config(hosturi, session)
        url = URI(hosturi+'/rest/appliance/access/ssh')
        response = Helpers.http_get_request(url,session)
        body = JSON.parse(response.read_body)
        return body['value']
      end
      # Set SSH configuration
      def Access.set_vami_ssh_config(hosturi, session, state)
        # foo
      end
      # Get Shell (bash) configuration
      def Access.get_vami_shell_config(hosturi, session)
        url = URI(hosturi+'/rest/appliance/access/shell')
        response = Helpers.http_get_request(url,session)
        body = JSON.parse(response.read_body)
        return [ body['value']['enabled'], body['value']['timeout'].to_s ]
      end
      # Set Shell (bash) configuration
      def Access.set_vami_shell_config(hosturi, session, state, timeout)
        url = URI(hosturi+'/rest/appliance/access/shell')
        case state
        when 'enabled'
          state_bool = 'true'
        when 'disabled'
          state_bool = 'false'
        else
          return "Error: only valid inputs are enabled and disabled\n"
        end
        if !(timeout.to_i.is_a? Integer)
          return "Error: timeout value provided is not an integer\n"
        end
        body = '{ "config": { "enabled" : ' + state_bool + ', "timeout" : ' + timeout + ' } }'
        response = Helpers.http_put_request(url, session, body)
        return response.code
      end
      # Get Console CLI configuration
      def Access.get_vami_consolecli_config(hosturi, session)
        url = URI(hosturi+'/rest/appliance/access/consolecli')
        response = Helpers.http_get_request(url,session)
        body = JSON.parse(response.read_body)
        return body['value']
      end
      # Set Console CLI configuration
      def Access.set_vami_consolecli_config(hosturi, session, state)
        url = URI(hosturi+'/rest/appliance/access/consolecli')
        case state
        when 'enabled'
          state_bool = 'true'
        when 'disabled'
          state_bool = 'false'
        else
          return "Error: only valid inputs are enabled and disabled\n"
        end
        body = '{ "enabled" : ' + state_bool + '}'
        response = Helpers.http_put_request(url, session, body)
        return response.code
      end
      # Get DCUI configuration
      def Access.get_vami_dcui_config(hosturi, session)
        url = URI(hosturi+'/rest/appliance/access/consolecli')
        response = Helpers.http_get_request(url,session)
        body = JSON.parse(response.read_body)
        return body['value']
      end
      # Set DCUI configuration
      def Access.set_vami_dcui_config(hosturi, session, state)
        # foo
      end
    end

    module Health
      # VAMI Health Status
    end

    module Networking
      # VAMI Networking
      # Get DNS Domains
      def Networking.get_dns_domains(hosturi, session)
        url = URI(hosturi+'/rest/appliance/networking/dns/domains')
        response = Helpers.http_get_request(url,session)
        body = JSON.parse(response.read_body)
        return body['value']
      end
      # Set DNS Domain list
      def Networking.set_dns_domains(hosturi, session, domain_list)
        # foo
      end
      # Add DNS Domain
      def Networking.add_dns_domain(hosturi, session, domain)
        # foo
      end
      # Get hostname
      def Networking.get_hostname(hosturi, session)
        url = URI(hosturi+'/rest/appliance/networking/dns/domains')
        response = Helpers.http_get_request(url,session)
        body = JSON.parse(response.read_body)
        return body['value']
      end
      # Set hostname
      def Networking.set_hostname(hosturi, session, hostname)
        # foo
      end
      # Test hostname resolution
      def Networking.test_hostname(hosturi, session, hostname)
        # foo
      end
      # Get DNS Servers
      def Networking.get_dns_servers(hosturi, session)
        # foo
      end
      # Set DNS Configuration
      def Networking.set_dns_config(hosturi, session, mode, server_list)
        # foo
      end
      # Add DNS Server
      def Networking.add_dns_server(hosturi, session, server_ip)
        # foo
      end
      # Test DNS Server reachability
      def Networking.test_dns_server(hosturi, session, server_ip)
        # foo
      end
    end
  end

  module Helpers
    # Helper functions
    # GET request
    def Helpers.http_get_request(hosturl, session)
      http = Net::HTTP.new(hosturl.host, hosturl.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(hosturl)
      request['vmware-api-session-id'] = session
      response = http.request(request)
      return response
    end
    # POST request
    def Helpers.http_post_request(hosturl, session, body)
      # foo
    end
    # PUT request
    def Helpers.http_put_request(hosturl, session, body)
      http = Net::HTTP.new(hosturl.host, hosturl.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Put.new(hosturl)
      request['vmware-api-session-id'] = session
      request['Content-Type'] = 'application/json'
      request['Accept'] = 'application/json'
      request.body = body
      response = http.request(request)
      return response
    end
    # DELETE request
    def Helpers.http_delete_request(hosturl, session)
      # foo
    end
  end
end
