#!/usr/bin/ruby
$LOAD_PATH << '../'
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

# Delete session token and print it out
puts 'Deleting session...'
del_session = VsphereREST::Session.delete_session(connection['hosturi'], session)
if del_session == '200'
  puts 'Session ticket deleted'
else
  puts 'Something went wrong deleting session, got return code ' + del_session
end
