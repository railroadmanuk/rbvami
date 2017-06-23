#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'VSphereREST'

hosturi = 'https://192.168.1.222'
username = 'administrator@vsphere.local'
password = 'VMware1!'

session = VSphereREST.get_session(hosturi, username, password)
puts 'Session: ' + session

ssh_config = VSphereREST.get_vami_ssh_config(hosturi,session)
puts 'SSH access: ' + (ssh_config ? 'enabled' : 'disabled')

bash_config = VSphereREST.get_vami_bash_config(hosturi,session)
puts 'BASH access: ' + (bash_config[0] ? 'enabled' : 'disabled') + \
     ' (timeout: ' + (bash_config[1] ? bash_config[1] : '0') + ' minutes)'
