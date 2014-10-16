require 'rspec'
require 'pry'
include RSpec

lib_dir = File.expand_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include? lib_dir

def tspdata_path
  File.join(__dir__, 'fixtures', 'TSPDATA.txt')
end
