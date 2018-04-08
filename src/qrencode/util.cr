module QRencode
  # Utility methods for `QRencode`.
  module Util
    extend self

    # Returns `true` if the given *byte* is a black module (dot).
    def black?(byte : UInt8)
      byte & 1 == 1
    end

    # Returns `true` if the given *byte* is a white module (dot).
    def white?(byte : UInt8)
      byte & 1 == 0
    end
  end
end
