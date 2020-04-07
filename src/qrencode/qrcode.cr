module QRencode
  class EncodeError < Exception
    include SystemError
  end

  # The main class for QR symbol generation.
  class QRcode
    private getter qrcode_p : LibQRencode::QRcode*

    # The version of the QR symbol.
    getter version : Int32

    # The width of the QR symbol.
    getter width : Int32

    # The actual module (dot) data of the QR symbol. `Util` contains methods for interacting
    # with these bytes.
    getter data : Bytes

    # Creates a new `QRcode` instance from *string*.
    #
    # *version* is a QR version code. If `0` (the default) is given, then `libqrencode` chooses
    # the minimum possible version.
    #
    # *level* is an `ECLevel` value, corresponding to the level of error-correction to apply.
    #
    # *hint* is an `EncodeMode` value, corresponding to the encoding used by the QR code.
    #
    # If *casesensitive* is set to `false`, then the data is encoded in all caps (as applies).
    #
    # If *micro* is set to `true`, then a Micro QR code is generated instead (experimental).
    #
    # Raises `Errno` on any of the following failure conditions:
    # * The given *string* is invalid given *hint* (`EINVAL`)
    # * Memory allocation fails (`ENOMEM`)
    # * The given *string* is too large to fit into a QR code (`ERANGE`)
    #
    # ```
    # qr = QRencode::QRcode.new("hello")
    # # Crystal strings are UTF-8, so this works without `EncodeMode::MODE_KANJI`!
    # qr2 = QRencode::QRcode.new("こんにちは")
    # ```
    def initialize(string : String, version = 0, level = ECLevel::MEDIUM,
                   hint = EncodeMode::MODE_8, casesensitive = true, micro = false)
      @qrcode_p = if micro
                    LibQRencode.encode_string_mqr(string, version, level, hint, casesensitive)
                  else
                    LibQRencode.encode_string(string, version, level, hint, casesensitive)
                  end

      raise EncodeError.from_errno("failed to generate qr code") if @qrcode_p.null?

      @version = qrcode_p.value.version
      @width = qrcode_p.value.width
      @data = Bytes.new(qrcode_p.value.data, width * width, read_only: true)
    end

    # Creates a new `QRcode` instance from *data*.
    #
    # Always uses `EncodeMode::MODE_8`.
    def initialize(data : Bytes, version = 0, level = ECLevel::MEDIUM, micro = false)
      @qrcode_p = if micro
                    LibQRencode.encode_data_mqr(data.size, data, version, level)
                  else
                    LibQRencode.encode_data(data.size, data, version, level)
                  end

      raise EncodeError.from_errno("failed to generate qr code") if @qrcode_p.null?

      @version = qrcode_p.value.version
      @width = qrcode_p.value.width
      @data = Bytes.new(qrcode_p.value.data, width * width, read_only: true)
    end

    # Destroys the instance's internal state.
    def finalize
      LibQRencode.free(qrcode_p)
    end

    # Yields each row in `#data`.
    def each_row(&block)
      data.each_slice(width) { |slice| yield slice }
    end
  end
end
