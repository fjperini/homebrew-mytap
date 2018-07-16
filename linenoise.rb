class Linenoise < Formula
  desc "A small self-contained alternative to readline and libedit"
  homepage "https://github.com/antirez/linenoise"
  url "https://github.com/antirez/linenoise/archive/1.0.tar.gz"
  sha256 "f5054a4fe120d43d85427cf58af93e56b9bb80389d507a9bec9b75531a340014"
  patch :DATA

  head "git://https://github.com/antirez/linenoise.git"
   
  # makedepends
  depends_on "cmake" => :build

  def install
    #cc -shared -fPIC linenoise.c -o liblinenoise.so
    #system "cc", "-shared", "-fPIC", "linenoise.c", "-o", "liblinenoise.a"
    system 'make'
    lib.install 'liblinenoise.a'
    include.install 'linenoise.h'
  end
end


__END__
Add static library to linenoise build.

diff --git a/Makefile b/Makefile
index a285410..12cf058 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,15 @@
+all: liblinenoise.a linenoise_example
+
+liblinenoise.a: linenoise.o
+	$(AR) -rc liblinenoise.a linenoise.o
+
+%.o: %.c
+	$(CC) $(CFLAGS) -o $@ -c $<
+
 linenoise_example: linenoise.h linenoise.c
 
 linenoise_example: linenoise.c example.c
 	$(CC) -Wall -W -Os -g -o linenoise_example linenoise.c example.c
 
 clean:
-	rm -f linenoise_example
+	rm -f linenoise_example linenoise.o liblinenoise.a
