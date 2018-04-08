require "../src/qrencode"

# ansiqr.cr: Given an input string, render it as a QR code using ANSI terminal colors
# Usage: ansiqr <input>

input = ARGV[0]

qr = QRencode::QRcode.new(input)
qr.each_row do |row|
  row.each do |byte|
    print (QRencode::Util.black?(byte) ? "\033[40m " : "\033[47m ") * 2
  end
  puts "\033[0m"
end
