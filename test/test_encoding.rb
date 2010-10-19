# encoding: utf-8
require 'helper'
require 'memcached_mock'

class TestEncoding < Test::Unit::TestCase

  context 'using a live server' do
    should 'support i18n content' do
      memcached do |dc|
        key = 'foo'
        bad_key = utf8 = 'ƒ©åÍÎ'

        assert dc.set(key, utf8)
        assert_equal utf8, dc.get(key)

        # keys must be ASCII
        assert_raise ArgumentError, /illegal character/ do
          dc.set(bad_key, utf8)
        end
      end
    end
  end
end