require 'rake/testtask'

task :test do
  $LOAD_PATH.unshift('spec')
  require 'spec_helper'
  Dir.glob('./spec/**/*_spec.rb') { |f| require f }
end

task default: :test
