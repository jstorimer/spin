# A Spin::Socket wraps a Unix socket

require 'tempfile' # for Dir::tmpdir
require 'digest/md5'
require 'socket'

module Spin
  class Socket
    # This returns a path in the top level of the tmpdir with
    # a name unique to spin and the pwd.
    def self.filepath
      slug = Digest::MD5.hexdigest ['spin', Dir.pwd].join('-')
      [Dir::tmpdir, slug].join('/')
    end

    def self.open
      UNIXServer.open(filepath)
    end
  end
end

