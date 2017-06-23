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

# Get our SSH configuration and print it out
ssh_config = VsphereREST::Vami::Access.get_vami_ssh_config(connection['hosturi'],session)
puts 'SSH access: ' + (ssh_config ? 'enabled' : 'disabled')

# Get our shell configuration and print it out
bash_config = VsphereREST::Vami::Access.get_vami_shell_config(connection['hosturi'],session)
puts 'BASH access: ' + (bash_config[0] ? 'enabled' : 'disabled') + \
     ' (timeout: ' + (bash_config[1] ? bash_config[1] : '0') + ' minutes)'

# Get our DCUI configuration and print it out
dcui_config = VsphereREST::Vami::Access.get_vami_dcui_config(connection['hosturi'],session)
puts 'DCUI config: ' + (dcui_config ? 'enabled' : 'disabled')

# Get our Console CLI configuration and print it out
consolecli_config = VsphereREST::Vami::Access.get_vami_consolecli_config(connection['hosturi'],session)
puts 'Console CLI config: ' + (consolecli_config ? 'enabled' : 'disabled')
