module QRencode
  # Error-correction levels for QR symbol generation.
  enum ECLevel
    LOW
    MEDIUM
    QUARTILE
    HIGH
  end

  # Encoding modes for QR symbol generation.
  # NOTE: `QR_MODE_NUL` and `QR_MODE_STRUCTURE` are for internal use only.
  enum EncodeMode
    MODE_NUL        = -1
    MODE_NUM        =  0
    MODE_AN
    MODE_8
    MODE_KANJI
    MODE_STRUCTURE
    MODE_ECI
    MODE_FNC1FIRST
    MODE_FNC1SECOND
  end
end
