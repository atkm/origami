## ks_alpha ##
Building on ks_base. Supports CentOS-[6.2,5.7]-[32,64]-bit and RedHat-6.2-64-bit.
The purpose is to show building an effective directory hierarchy is plausible
in conjunction with the current ERB template inheritance emulation scheme.

### Workflow ###

1. write a ruby hash and convert it to yaml (or just write a yaml file)
2. take a look at `def initialize` of `ks_base.rb`, where default values of
installation parameters are specified. Change a value to 'nil' if you
intend to use a seed file to provide that value.
3. run `ks_builder.rb`

    `./ks_builder.rb <seed1> <seed2>` ...  
	\*\*You can feed as many seed files as you need.
