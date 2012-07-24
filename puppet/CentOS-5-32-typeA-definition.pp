$targetdir = "/Users/atsuya/Code/veewee/definitions/model_definitions/EL/CentOS/5.x/32/typeA"
$targetfile = "/Users/atsuya/Code/veewee/definitions/model_definitions/EL/CentOS/5.x/32/typeA/definition.rb"

file {'typeAdir':
  path => $targetdir,
  ensure => directory,
  before => Notify['defdir'],
}

file {'typeAfile':
  path => $targetfile,
  ensure => present,
  before => Notify['deffile'],
  require => Exec['makedefinition'],
}

notify {'deffile':
  message => 'File definition.rb has been created.'
}

notify {'defdir':
  message => 'A directory containing definition.rb has been created.'
}

exec {'makedefinition':
  command => "VWFdefine.rb CentOS-5-32-typeA --definition --target $targetdir",
  path => ['/Users/atsuya/Code/VWF_templating_engine/bin','/usr/bin'],
  creates => $targetfile,
  cwd => "/Users/atsuya/Code/VWF_templating_engine",
  logoutput => true
}
