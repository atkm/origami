### Directory containing ks_base.erb and seeds/ directory. The same for definition.
module Origami

  def project_root
    return File.expand_path(File.join(File.dirname(__FILE__), '..'))
  end

  def ks_file_server
    return '192.168.100.225'
  end
  def project_dir
    return File.expand_path(
                            File.join(File.dirname(__FILE__),'../lib')
                            )
  end 
  def ks_dir
    return File.join(project_dir,'origami/inventory/kickstart/')
  end
   def defn_dir
    return File.join(project_dir,'origami/inventory/definition/')
  end
   def autoinst_dir
    return File.join(project_dir,'origami/inventory/autoinst/')
  end
  def preseed_dir
    return File.join(project_dir,'origami/inventory/preseed/')
  end
  def ks_seeds_dir
    return File.join(ks_dir,'seeds')
  end
  def defn_seeds_dir
    return File.join(defn_dir,'seeds')
  end
  def autoinst_seeds_dir
    return File.join(autoinst_dir,'seeds')
  end
  def preseed_seeds_dir
    return File.join(preseed_dir,'seeds')
  end
end
