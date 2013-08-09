vagrant-helper
==============

Common Vagrant Helpers for User Config, OS Detection, Etc.

## What is vagrant-helper?

At DDM, we're starting to use Vagrant a lot. Because it's just Ruby, we've found
that we are adding a little bit of programming to our ```Vagrantfile``` to make
things easier to share among our team. So we've made this repo intended to be a 
submodule in our vagrant projects.

## Installation

### Git

In your git project, add this as a submodule:

```
cd /path/to/vagrant/root/
git submodule add https://github.com/deseretdigital/vagrant-helper.git helper
```

### Other

You can [download the latest vagrant-helper](https://github.com/deseretdigital/vagrant-helper/archive/master.zip), 
create a directory in your vagrant project called "helper" and then move the
unziped files there.

## Usage

### Setup

At the top of your ```vagrantfile``` you can include the helper libraries like
so:

```ruby
require 'lib/core'		# Required
require 'lib/utils'		# If you want to use the Utils helpers
require 'lib/config'	# If you want to use the Config helpers
```

### User Configs

Sometimes it is helpful to allow some customization of a Vagrant project for things
like the location of files you would like to mount. Many times a project will
require several mounts, and these paths on the host machine can vary from
developer to developer.

You can create in your project the ```config``` directory and add a ```prefs.yml```
file. It can then look something like this:

```yaml
vm:
  provider: virtualbox
  box:
    name: precise
    path: base
  network: 10.13.37.10
  forward:
    http: 8080
    ssh:  2222
```

Then in your Vagrantfile you can load the User Preferences. You can even check to make
sure they were loaded.

```ruby
require 'lib/core'		# Required
require 'lib/config'	# If you want to use the Config helpers

Vagrant.configure("2") do |config|
    # Load the user preferences in config/prefs.yml
    if (prefs = UserConfig.load(:prefs)).empty?
        abort("Error: no user preferences were loaded, make sure you have created 'config/prefs.yml'")
    end

  	# [ ... continue Vagrantfile settings ... ]

end
```

Finally, to use a config setting you can just do this:

```ruby
config.vm.network :hostonly, ip: prefs['vm']['network']
```

