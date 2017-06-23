#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'vSphereREST'

hosturi = 'https://192.168.1.222'
username = 'administrator@vsphere.local'
password = 'VMware1!'

session = VsphereREST::Session.get_session(hosturi, username, password)
puts 'Session: ' + session

ssh_config = VsphereREST::VamiAccess.get_vami_ssh_config(hosturi,session)
puts 'SSH access: ' + (ssh_config ? 'enabled' : 'disabled')

bash_config = VsphereREST::VamiAccess.get_vami_shell_config(hosturi,session)
puts 'BASH access: ' + (bash_config[0] ? 'enabled' : 'disabled') + \
     ' (timeout: ' + (bash_config[1] ? bash_config[1] : '0') + ' minutes)'

dcui_config = VsphereREST::VamiAccess.get_vami_dcui_config(hosturi,session)
puts 'DCUI config: ' + (dcui_config ? 'enabled' : 'disabled')

consolecli_config = VsphereREST::VamiAccess.get_vami_consolecli_config(hosturi,session)
puts 'Console CLI config: ' + (consolecli_config ? 'enabled' : 'disabled')
