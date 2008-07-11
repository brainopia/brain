# Build the rdocs HTML Files
Rake::RDocTask.new(:docs => :clean) do |rd|
  rd.main = "README.txt"
  rd.rdoc_dir = 'doc'
  rd.rdoc_files.include("README.txt", "lib/**/*.rb")
  rd.rdoc_files.exclude("lib/brain/version.rb")
  
  title = "#{$hoe.name}-#{$hoe.version} Documentation"
  rd.options << "-t #{title}"
end