module VsphereREST
  # Import dependencies
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  # Session management
  module Session
    # Create new session
    def self.get_session(hosturi, username, password)
      url = URI(hosturi + '/rest/com/vmware/cis/session')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(url)
      request.basic_auth(username, password)
      request['cookie'] = 'vmware-api-session-id'
      response = http.request(request)
      body = JSON.parse(response.read_body)
      body['value']
    end

    # Delete session
    def self.delete_session(hosturi, session)
      url = URI(hosturi + '/rest/com/vmware/cis/session')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Delete.new(url)
      request['vmware-api-session-id'] = session
      response = http.request(request)
      response.code
    end
  end

  # VAMI Access
  module Vami
    module Access
      # Get SSH configuration
      def self.get_vami_ssh_config(hosturi, session)
        url = URI(hosturi + '/rest/appliance/access/ssh')
        response = Helpers.http_get_request(url, session)
        body = JSON.parse(response.read_body)
        body['value']
      end

      # Set SSH configuration
      def self.set_vami_ssh_config(hosturi, session, state)
        url = URI(hosturi + '/rest/appliance/access/ssh')
        case state
        when 'enabled'
          state_bool = 'true'
        when 'disabled'
          state_bool = 'false'
        else
          "Error: only valid inputs are enabled and disabled\n"
        end
        body = '{ "enabled" : ' + state_bool + '}'
        response = Helpers.http_put_request(url, session, body)
        response.code
      end

      # Get Shell (bash) configuration
      def self.get_vami_shell_config(hosturi, session)
        url = URI(hosturi + '/rest/appliance/access/shell')
        response = Helpers.http_get_request(url, session)
        body = JSON.parse(response.read_body)
        [body['value']['enabled'], body['value']['timeout'].to_s]
      end

      # Set Shell (bash) configuration
      def self.set_vami_shell_config(hosturi, session, state, timeout)
        url = URI(hosturi + '/rest/appliance/access/shell')
        case state
        when 'enabled'
          state_bool = 'true'
        when 'disabled'
          state_bool = 'false'
        else
          "Error: only valid inputs are enabled and disabled\n"
        end
        unless timeout.to_i.is_a? Integer
          "Error: timeout value provided is not an integer\n"
        end
        body = '{ "config": { "enabled" : ' + state_bool + ', "timeout" : ' + timeout + ' } }'
        response = Helpers.http_put_request(url, session, body)
        response.code
      end

      # Get Console CLI configuration
      def self.get_vami_consolecli_config(hosturi, session)
        url = URI(hosturi + '/rest/appliance/access/consolecli')
        response = Helpers.http_get_request(url, session)
        body = JSON.parse(response.read_body)
        body['value']
      end

      # Set Console CLI configuration
      def self.set_vami_consolecli_config(hosturi, session, state)
        url = URI(hosturi + '/rest/appliance/access/consolecli')
        case state
        when 'enabled'
          state_bool = 'true'
        when 'disabled'
          state_bool = 'false'
        else
          "Error: only valid inputs are enabled and disabled\n"
        end
        body = '{ "enabled" : ' + state_bool + '}'
        response = Helpers.http_put_request(url, session, body)
        response.code
      end

      # Get DCUI configuration
      def self.get_vami_dcui_config(hosturi, session)
        url = URI(hosturi + '/rest/appliance/access/dcui')
        response = Helpers.http_get_request(url, session)
        body = JSON.parse(response.read_body)
        body['value']
      end

      # Set DCUI configuration
      def self.set_vami_dcui_config(hosturi, session, state)
        url = URI(hosturi + '/rest/appliance/access/dcui')
        case state
        when 'enabled'
          state_bool = 'true'
        when 'disabled'
          state_bool = 'false'
        else
          "Error: only valid inputs are enabled and disabled\n"
        end
        body = '{ "enabled" : ' + state_bool + '}'
        response = Helpers.http_put_request(url, session, body)
        response.code
      end
    end

    # VAMI Health Status
    module Health
      # foo
    end

    # VAMI Networking
    module Networking
      # Get DNS Domains
      def self.get_dns_domains(hosturi, session)
        url = URI(hosturi + '/rest/appliance/networking/dns/domains')
        response = Helpers.http_get_request(url, session)
        body = JSON.parse(response.read_body)
        body['value']
      end

      # Set DNS Domain list
      def self.set_dns_domains(hosturi, session, domain_list)
        # foo
      end

      # Add DNS Domain
      def self.add_dns_domain(hosturi, session, domain)
        # foo
      end

      # Get hostname
      def self.get_hostname(hosturi, session)
        url = URI(hosturi + '/rest/appliance/networking/dns/domains')
        response = Helpers.http_get_request(url, session)
        body = JSON.parse(response.read_body)
        body['value']
      end

      # Set hostname
      def self.set_hostname(hosturi, session, hostname)
        # foo
      end

      # Test hostname resolution
      def self.test_hostname(hosturi, session, hostname)
        # foo
      end

      # Get DNS Servers
      def self.get_dns_servers(hosturi, session)
        # foo
      end

      # Set DNS Configuration
      def self.set_dns_config(hosturi, session, mode, server_list)
        # foo
      end

      # Add DNS Server
      def self.add_dns_server(hosturi, session, server_ip)
        # foo
      end

      # Test DNS Server reachability
      def self.test_dns_server(hosturi, session, server_ip)
        # foo
      end
    end
  end

  # Helper functions
  module Helpers
    # GET request
    def self.http_get_request(hosturl, session)
      http = Net::HTTP.new(hosturl.host, hosturl.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(hosturl)
      request['vmware-api-session-id'] = session
      response = http.request(request)
      response
    end

    # POST request
    def self.http_post_request(hosturl, session, body)
      # foo
    end

    # PUT request
    def self.http_put_request(hosturl, session, body)
      http = Net::HTTP.new(hosturl.host, hosturl.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Put.new(hosturl)
      request['vmware-api-session-id'] = session
      request['Content-Type'] = 'application/json'
      request['Accept'] = 'application/json'
      request.body = body
      response = http.request(request)
      response
    end

    # DELETE request
    def self.http_delete_request(hosturl, session)
      # foo
    end
  end
end
