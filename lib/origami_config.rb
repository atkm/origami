### Directory containing ks_base.erb and seeds/ directory. The same for definition.
module Origami
  def project_dir
    return File.expand_path(
                            File.join(File.dirname(__FILE__),'../lib')
                            )
  end 
  def ks_dir
    return project_dir + '/kickstart/'
  end
  def defn_dir
    return project_dir + '/definition/'
  end
  
end
