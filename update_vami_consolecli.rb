#!/usr/bin/ruby
$LOAD_PATH << '.'
# Load custom vSphereREST module
require 'vSphereREST'

# Environment specific details
connection = {
  'hosturi' => 'https://192.168.1.222',
  'username' => 'administrator@vsphere.local',
  'password' => 'VMware1!'
}

# Get our session token and print it out
session = VsphereREST::Session.get_session(connection['hosturi'], \
          connection['username'], connection['password'])
puts 'Session: ' + session

print "Type enabled or disabled:\n"
input = gets.strip

config_consolecli = VsphereREST::Vami::Access.set_vami_consolecli_config(connection['hosturi'],session,input)
if config_consolecli == '200'
  print "SUCCESS: Update was successful, console CLI is now " + input + "\n"
else
  print config_consolecli
end
