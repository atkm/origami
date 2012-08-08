### build_helper.rb
###

module Origami

  def file_location(instruction,opt)
    ## Locations of yaml files
    return File.join(base_seed_path(instruction), opt + '.yml')
  end

  def base_seed_path(instruction)
    dir = {
      'definition' => defn_dir,
      'kickstart' => ks_dir,
      'preseed' => preseed_dir,
      'autoyast'=> autoyast_dir
    }
    return File.join(dir[instruction],'seeds')
  end

  def dependencies(ostype,opt)
    ## specify dependencies for each config option
    ## OS_TYPE_ID. depends on 'distro' 'version' 'arch'
    #  os_type_id.yml is pretty much the same as ostypes.yml
    #  but rewriting it to a nested hash serves this better.
    ## ISO name (must be in /veewee/iso/). depends on 'distro' 'version' 'arch'
    ## BOOT_CMD_SEQUENCE. depends on 'family' 'version'
    ## KICK_START_FILE. depends on same as above
    ## POSTINSTALL_FILES. depends on 'distro' 'version' 'type'
    #  (and probably a bit on 'arch' as well but not doing that right now)
    ## REPONAME
    ## PKGS
    distro, version, arch, type, family = resolve(ostype)
    dictionary = {
      'os_type_id' => [distro, version, arch],
      'iso_file' => [distro, version, arch],
      'boot_cmd_sequence' => [family,version],
      # 'kickstart_file' option is deprecated
      #'kickstart_file' => [family,version],
      'postinstall_files' => [distro,version,type],
      'reponame' => [distro,version],
      'suite' => [distro,version],
      'pkgs' => [distro,version,type]
    }
    return dictionary[opt]
  end

end # Module
