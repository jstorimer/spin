require 'minitest/autorun'
require_relative '../../lib/spin/alternate'

describe Spin::Alternate do
  it 'matches a file to its test' do
    Spin::Alternate.for('app/models/product.rb').must_include 'spec/models/product_spec.rb'
  end

  it 'eliminates non-existent files' do
    Spin::Alternate.for('app/models/product.rb').wont_include 'test/unit/product_test.rb'
  end

  it 'returns an array' do
    Spin::Alternate.for('app/models/product.rb').must_be_instance_of Array
  end
end

