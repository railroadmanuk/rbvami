#!/usr/bin/ruby
$LOAD_PATH << '.'
require 'VSphereREST'

hosturi = 'https://192.168.1.222'
username = 'root'
password = 'VMware1!'

session = VSphereREST.get_session(hosturi, username, password)
puts 'Session: ' + session

ssh_config = VSphereREST.get_vami_ssh_config(hosturi,session)
puts 'SSH Config: ' + ssh_config
