require "./spec_helper"

describe QRencode::QRcode do
  describe "#initialize" do
    it "accepts a string" do
      qr = QRencode::QRcode.new("foobar")
      qr.should be_a(QRencode::QRcode)
    end

    it "accepts Bytes" do
      qr = QRencode::QRcode.new("foobar".to_slice)
      qr.should be_a(QRencode::QRcode)
    end

    it "fails when given a bad version" do
      expect_raises QRencode::EncodeError, "failed to generate qr code" do
        QRencode::QRcode.new("foobar", version: 100)
      end
    end

    it "fails when given a huge input" do
      expect_raises QRencode::EncodeError, "failed to generate qr code" do
        QRencode::QRcode.new("foobar" * 1024)
      end

      expect_raises QRencode::EncodeError, "failed to generate qr code" do
        QRencode::QRcode.new(("foobar" * 1024).to_slice)
      end
    end
  end

  describe "#version" do
    it "matches the initialized version" do
      qr = QRencode::QRcode.new("foobar", version: 10)
      qr.version.should eq(10)
    end

    it "defaults to 1 with a small input" do
      qr = QRencode::QRcode.new("a")
      qr.version.should eq(1)
    end
  end

  describe "#width" do
    it "corresponds to the dimensions of data" do
      qr = QRencode::QRcode.new("foobar")
      qr.data.size.should eq(qr.width * qr.width)
    end
  end

  describe "#data" do
    it "is Bytes" do
      qr = QRencode::QRcode.new("foobar")
      qr.data.should be_a(Bytes)
    end
  end

  describe "#each_row" do
    it "yields rows that are each #width bytes" do
      qr = QRencode::QRcode.new("foobar")

      qr.each_row do |row|
        row.size.should eq(qr.width)
      end
    end

    it "yields #width rows in total" do
      qr = QRencode::QRcode.new("foobar")

      rc = 0
      qr.each_row { |_| rc += 1 }

      rc.should eq(qr.width)
    end
  end
end
