# origami #

* * * * *

A templating engine for veewee's configuration files, whose goal is to complement veewee.
It creates working configuration files just from os/distro names. 
Also, veewee has a poor library of configuration files for its use with Fusion.
veewee-configuration files created by this program can serve as templates for those who are somewhat familiar with veewee and/or kickstart.

veewee-configuration files = `definition.rb` and kickstart file or `ks.cfg`.
Although `ks.cfg` is not technically a configuration file for veewee, I do not see any harm in doing so.
When I say 'configuration file' in the documentation it probably means this program's configuration
This is about my program, after all.
I will make it explicit when I refer to `definition.rb` and `ks.cfg`.

`ks_base.erb` and `definition_base.erb` are provided as foundations of veewee-configuration files. These contain bare-minimum information and _no options_ are specified here.

From here there are few levels of configurations but notably the following two are dealt with in diferent manner:

1. Default configuration (applies to all distros)
2. Distro-specific configuration

### 1. Default configuration ###
These are options that supposedly do not require any change for all intended purposes. They are defined in `ks_base.rb` and `definition_base.rb`. From a design point of view, this should be done in the same way as distro-specific configuration i.e. there should be a yaml file that holds all default values. (It will be a piece of cake to implement this.)

### 2. Distro-specific configuration ###
Distro-specific configuration are, on the other hand, are the primary focus. Under `kickstart/` and `definition/` directories there are `seed/` directories, and they contain yaml files.
These yaml files serve as primary configuration file for creating veewee-configuration files, which I call _seeds_.
These tell the program the looks of `definition.rb` and `ks.cfg` for each distro.
Different option may have different dependencies (distro, version, arch, type, and any of their combinations), so seed files may look different, as well.
See `seed_builder.rb`.
