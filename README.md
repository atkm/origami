# origami #
A templating engine which complements veewee.
--------
[veewee](http://github.com/jedi4ever/veewee) makes building virtual machines easy, but origami takes a step further and makes the process even easier,
especially for those who wish to quickly deploy numbers of VMs that are configured differently.
A typical workflow of a veewee user is

1. Choose a template to work with. 
2. `veewee define box-name template-name`
3. Modify `definition.rb` and `ks.cfg`
4. `veewee build box-name`.

By introducing origami it becomes

1. `origami --name CentOS-5-32-server`
2. `veewee build CentOS-5-32-server`.

Thus origami lets you bypass the editing of templates and initiate building a virtual machine immediately.

Default configuration (applies to all distros)
Distro-specific configuration

### Default configuration ###
These are options that supposedly do not require any change for all intended purposes. They are defined in `ks_base.rb` and `definition_base.rb`. From a design point of view, this should be done in the same way as distro-specific configuration i.e. there should be a yaml file that holds all default values. (It will be a piece of cake to implement this.)

### Distro-specific configuration ###
Distro-specific configuration are, on the other hand, are the primary focus. Under `kickstart/` and `definition/` directories there are `seed/` directories, and they contain yaml files.
These yaml files serve as primary configuration file for creating veewee-configuration files, which I call _seeds_.
These tell the program the looks of `definition.rb` and `ks.cfg` for each distro.
Different option may have different dependencies (distro, version, arch, type, and any of their combinations), so seed files may look different, as well.
See `seed_builder.rb`.


_Notes_:

1. `mseed.rb` and `namegen.rb` are useful tools for making seeds.
