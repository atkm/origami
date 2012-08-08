# How to add an inventory #

1. Take a working configuration file (e.g. ks.cfg, autoyast.yml)

2. Replace portions of the file with ERB statements and name it `something_base.erb`. The simplest
   one, which suffices for most purposes, is <%= variable %>. A loop through an array is also useful.
   See [the ruby doc](http://ruby-doc.org/stdlib-1.9.3/libdoc/erb/rdoc/ERB.html). It's surprisingly helpful.  
   
   Create a directory under `origami/lib/inventory`. Create a directory called `seed/` under the
   directory just created. Refer to the other documentation about writing seed.
   
3. Create a corresponding `something_base.rb` file. See `ks_base.rb` for an example.
   In `something_base.rb` write a class `SomethingBase < Base` with attr_accessor of all
   variables as well as values of those variables at initialization are defined.
   Choose `nil` as an initial value if there's no default. 

4. See #build\_from\_seed method in `build_from_seed.rb` and add `something_erb` if necessary.
   It is recommended to define the path to `lib/origami/inventory/something` in `lib/origami_config.rb` if adding a new directory.

5. Go to #get\_vars method in `seed_builder.rb`. Add a new key-value pair in the hash such as
   `'something' => ['variable1', 'variable2', 'variable3']`.
   This tells origami what values are missing from the erb template.

6. Then in #ks\_defn\_builder method of `ks_defn_builder.rb` add an appropriate hash entry.

7. Finally modify `build_helper.rb`. #base\_seed\_path method: Add a hash entry that points
   to the method you defined in 4. Specify dependencies of each variable in #dependencies method.
