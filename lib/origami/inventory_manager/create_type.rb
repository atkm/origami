### create_type.rb
### Interface to the yaml files in [kickstart|definition]/seeds/ directory.
### Make a new type available for origami.

module Origami
  def create_type(attributes)
    name = attributes[:name]
    iso_file = attributes[:iso_file]
    postinstall_files = attributes[:postinstall_files]
    pkgs = attributes[:pkgs]
  end
end
