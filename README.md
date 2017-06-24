# rbvami - a Ruby module for managing vCSA VAMI
## Overview
A Ruby module for configuring vCSA 6.5 VAMI via public REST API

!['rbvami'](./public/assets/images/rbvami_logo.png)

## Use
Drop `vSphereREST.rb` into a folder with your code, import it using `require 'vSphereREST'` and functions should be available for use.

Get and store a session ticket using `VsphereREST::Session.get_session(hosturi,username,password)`

## Available functions
### Session
* Get Session - `VsphereREST::Session.get_session(hosturi,username,password)`
* Delete Session - `VsphereREST::Session.delete_session(hosturi,session)`

### VAMI Access
* Get SSH Config - `VsphereREST::Vami::Access::get_vami_ssh_config(hosturi, session)`
* Set SSH Config - `VsphereREST::Vami::Access::set_vami_ssh_config(hosturi, session, state)`
* Get Shell/BASH Config - `VsphereREST::Vami::Access::get_vami_shell_config(hosturi, session)`
* Set Shell/BASH Config - `VsphereREST::Vami::Access::set_vami_shell_config(hosturi, session, state, timeout)`
* Get Console CLI Config - `VsphereREST::Vami::Access::get_vami_consolecli_config(hosturi, session)`
* Set Console CLI Config - `VsphereREST::Vami::Access::set_vami_consolecli_config(hosturi, session, state)`
* Get DCUI Config - `VsphereREST::Vami::Access::get_vami_dcui_config(hosturi, session)`
* Set DCUI Config - `VsphereREST::Vami::Access::set_vami_dcui_config(hosturi, session, state)`

## Example Usage
Example scripts can be found in the `./scripts` folder, these are also used to test the module. The following section should be modified for your environemnt:

```ruby
connection = {
  'hosturi' => 'https://192.168.1.222',
  'username' => 'administrator@vsphere.local',
  'password' => 'VMware1!'
}
```

## Development Ideas
* Initially cover just VAMI functionality, later may add full REST coverage
* Will not include 'techpreview' API calls at this stage
* Idea is to develop module into a Chef cookbook for managing VAMI configuration
