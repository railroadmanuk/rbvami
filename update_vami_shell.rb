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

print "========================\nUpdate BASH shell access\n========================\n"
print "Type enabled or disabled:\n"
input = gets.strip
print "Enter timeout in seconds, use 0 if disabling BASH:\n"
timeout = gets.strip

config_consolecli = VsphereREST::Vami::Access.set_vami_shell_config(connection['hosturi'],session,input,timeout)
if config_consolecli == '200'
  print "SUCCESS: Update was successful, BASH is now " + input + ", with timeout " + timeout + " minutes\n"
else
  print config_consolecli
end
