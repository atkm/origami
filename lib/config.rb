### Directory containing ks_base.erb and seeds/ directory. The same for definition.
module Origami
  
  def ks_dir
    return File.expand_path("~/Code/origami/lib/kickstart/")
  end
  def defn_dir
    return File.expand_path("~/Code/origami/lib/definition/")
  end
  
end
