qrencode.cr
===========

![license](https://raster.shields.io/badge/license-MIT%20with%20restrictions-green.png)
[![Build Status](https://img.shields.io/github/workflow/status/woodruffw/qrencode.cr/CI/master)](https://github.com/woodruffw/qrencode.cr/actions?query=workflow%3ACI)

Crystal bindings for [libqrencode](https://fukuchi.org/works/qrencode/index.html.en).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  qrencode:
    github: woodruffw/qrencode.cr
    branch: master
```

`libqrencode` is required. On Debian-based systems, it can be installed via:

```bash
$ sudo apt install libqrencode-dev
```

## Usage

`QRencode` provides methods for generating a QR symbol from various inputs (ASCII/UTF8 text, numerics,
Kanji (shift-JIS), etc).

It does *not* perform the task of rendering QR symbol data to an image format (e.g., PNG) -- it's
up to you (or a client library) to do that.

```crystal
require "qrencode"

qr = QRencode::QRcode.new("this is my input string")

qr.version
qr.width
qr.data

qr.each_row do |row|
  # each row is `width` bytes
  row.each do |byte|
    if QRencode::Util.black? byte
      print "B"
    else
      print "W"
    end
  end
  puts
end
```

Check out the [examples/](examples/) directory.

## Contributing

1. Fork it (https://github.com/woodruffw/qrencode/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [woodruffw](https://github.com/woodruffw) William Woodruff - creator, maintainer
