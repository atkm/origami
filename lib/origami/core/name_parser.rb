### name_parser.rb
### Methods to parse a string of the format
### <distro>-<version>-<arch>-<type>

module Origami
  ## Parses the input into an array
  def resolve(ostype)
    info = ostype.split('-')
    distro = info[0]
    version = info[1]
    arch = info[2]
    type = info[3]
    family = find_family(distro) 
    return distro, version, arch, type, family
  end

  ## Takes a distro name and returns the OS family that
  ## it belongs to (i.e. EL, Deb(ian), SuSE)
  def find_family(distro)
    el = ['CentOS','RedHat','SL','Oracle','EL']
    deb = ['Ubuntu','Debian','Deb']
    suse = ['SLES','openSUSE','SUSE']
    os_family = [el, deb, suse]
    family = ''
    os_family.each do |type|
      if type.include?(distro)
        return type.last
      end
    end
  end

  def choose_instruction(name)
    family = resolve(name)[4]
    instruction = {'EL' => 'kickstart','Deb' => 'preseed', 'SUSE' => 'autoinst'}
    return instruction[family]
  end
end
