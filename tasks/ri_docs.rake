desc 'Generate ri locally for testing.'
task :ri_docs => :clean do
  sh %q{ rdoc --ri -o ri lib }
end