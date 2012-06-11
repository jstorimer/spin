require 'minitest/autorun'
require_relative '../../lib/spin/socket'

describe Spin::Socket do
  describe '#filepath' do
    before do
      @filepath = Spin::Socket.filepath
    end

    it 'is in the tmpdir' do
      p @filepath
      @filepath.must_include Dir::tmpdir
    end

    it "includes a digested version of 'spin' and the pwd" do
      @filepath.must_include digest("spin-#{Dir.pwd}")
    end

    def digest(string)
      Digest::MD5.hexdigest(string)
    end
  end
end

