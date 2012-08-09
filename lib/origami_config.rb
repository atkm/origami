### Directory containing ks_base.erb and seeds/ directory. The same for definition.
module Origami
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

end
