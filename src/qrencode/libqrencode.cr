module QRencode
  # C bindings for `libqrencode`.
  @[Link("qrencode")]
  lib LibQRencode
    struct QRcode
      version : LibC::Int
      width : LibC::Int
      data : LibC::UChar*
    end

    fun encode_string = QRcode_encodeString(string : LibC::Char*, version : LibC::Int, level : ::QRencode::ECLevel, hint : ::QRencode::EncodeMode, casesensitive : LibC::Int) : QRcode*
    fun encode_string_mqr = QRcode_encodeStringMQR(string : LibC::Char*, version : LibC::Int, level : ::QRencode::ECLevel, hint : ::QRencode::EncodeMode, casesensitive : LibC::Int) : QRcode*
    fun encode_data = QRcode_encodeData(size : LibC::Int, data : LibC::UChar*, version : LibC::Int, level : ::QRencode::ECLevel) : QRcode*
    fun encode_data_mqr = QRcode_encodeDataMQR(size : LibC::Int, data : LibC::UChar*, version : LibC::Int, level : ::QRencode::ECLevel) : QRcode*
    fun free = QRcode_free(qrcode : QRcode*) : Void
  end
end
