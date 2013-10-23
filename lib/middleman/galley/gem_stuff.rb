require 'pathname'

module Middleman::Galley::GemStuff
  def this_path
    @this_path ||=
      begin
        this = 'middleman-galley'
        this = Gem::Specification.find_by_name this
        Pathname this.gem_dir
      end
  end

  def here relative_path
    (this_path + relative_path).to_s
  end
end
