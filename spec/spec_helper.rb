require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
require 'pry'

lib_dir = File.expand_path(File.join(__dir__, '..', 'lib'))
$LOAD_PATH.unshift lib_dir unless $LOAD_PATH.include? lib_dir

require 'traveling_salesman'

def tspdata_path
  File.join(__dir__, 'fixtures', 'TSPDATA.txt')
end
