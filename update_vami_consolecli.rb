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
