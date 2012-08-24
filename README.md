# origami #
A templating engine which complements veewee.  

## Introduction ##
[veewee](http://github.com/jedi4ever/veewee) makes building virtual machines easy but origami takes a step further and makes the process even easier,
especially for those who wish to quickly deploy numbers of VMs that are configured differently.
Without origami a typical workflow of a veewee user would be

1. Choose a template to work with. 
2. `veewee define my-CentOS-6.2-server CentOS-6.2-i386-netboot`
3. Modify `definition.rb` and `ks.cfg`
4. `veewee build box-name`.

By introducing origami it becomes

1. `origami --name CentOS-6.2-i386-server`
2. `veewee build CentOS-6.2-i386-server`

Thus origami lets you bypass the editing of templates and initiate building a virtual machine immediately.
Also, [a wrapper for origami and veewee](http://github.com/akumano/seisan-line) is available!

## Configuration ##
Managing veewee definitions is cumbersome because it requires you to create a configuration (i.e. `definition.rb` and `ks.cfg`) on a per-distro basis.
On the other hand, origami maintains configurations on a per-option basis.
The power of this approach is immense when you need to maintain a long list of VMs.
For example, if you want to change what packages are installed on your `Oracle-5.8-i386-server`,
you go to a corresponding yaml file, `pkgs.yml`, which might look like:

    # pkgs.yml
    ---
    Oracle:
      '5.8':
        server:
        - openssh-server
        desktop:
        - openssh-server
        - ruby
      '6':
        typeA:
        - openssh-server
        - git
        typeB:
        - openssh-server
        - git
        - ruby
    CentOS:
      '6': ...
        .
        .
    Ubuntu:
      '10': ...
        .
        .
        .
    SLES:
      '11': ...

and change the corresponding value in the yaml hash.
Once you edit all yaml files (which may include `boot_cmd_sequence.yml`, `kickstart_file`, and so on), 
you have a whole ensemble of different flavors of distros that you can start building just from their names.
I said 'all' in the previous sentence, but the number of yaml files can be small or large,
depending on your needs.
You need to create a yaml file for a parameter only if the parameter needs to be varied, and the others, which are fixed for any kind of VM,
are specified in a master template. The end result is instead of having an ever-growing number of definitions in your `veewee/definitions` directory,
you just have a fixed number of yaml files to configure installation parameters.

### How To ###
origami was written for [seisan-line](http://github.com/akumano/seisan-line).
The documentation for seisan-line includes how to use origami.
