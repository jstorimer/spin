# A Spin::Socket wraps a Unix socket

require 'tempfile' # for Dir::tmpdir
require 'digest/md5'

module Spin
  class Socket
    # This returns a path in the top level of the tmpdir with
    # a name unique to spin and the pwd.
    def self.filepath
      slug = Digest::MD5.hexdigest ['spin', Dir.pwd].join('-')
      [Dir::tmpdir, slug].join('/')
    end
  end
end

