class Spglib < Formula
  desc "C library for finding and handling crystal symmetries"
  homepage "https://atztogo.github.io/"
  url "https://github.com/atztogo/spglib/archive/v1.10.3.tar.gz"
  sha256 "43776b5fb220b746d53c1aa39d0230f304687ec05984671392bccaf850d9d696"

  head "git://github.com/atztogo/spglib.git"
   
  # makedepends
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build

  def install
      system "aclocal"
      system "autoheader"
      system "glibtoolize"
      system "touch INSTALL NEWS README AUTHORS"
      system "automake -acf"
      system "autoconf"
      system "./configure", "--disable-debug", "--disable-dependency-tracking", "--disable-silent-rules", "--prefix=#{prefix}"
      system "make", "install"
    #end
  end
end