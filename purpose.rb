class Labplot < Formula
  desc "KDE Application for interactive graphing and analysis of scientific data"
  homepage "https://labplot.kde.org/"
  url "http://download.kde.org/stable/labplot/2.5.0/labplot-2.5.0.tar.xz"
  sha256 "f1ef2d95a4d4f18902e38cd1f2f79d041d4eeed1eb7f6284ec9a6a6954792225"

  head "git://anongit.kde.org/labplot.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdelibs4support" => :build
  depends_on "KDE-mac/kde/kf5-kdesignerplugin" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
    
  #depends_on "cantor" => :optional
  depends_on "netcdf"
  depends_on "cfitsio"
  depends_on "fftw"
  depends_on "gsl"
  #depends_on "qt5-serialport"
  depends_on "libcerf"
    
  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{prefix}/bin"
    #args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    #args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    #args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    #args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"
      
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
    
  def post_install
    mkdir_p HOMEBREW_PREFIX/share/labplot
    ln_sf HOMEBREW_PREFIX/share/icons/breeze/breeze-icons.rcc, HOMEBREW_PREFIX/share/labplot/icontheme.rcc
  end
    
  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
       ln -sf "#{prefix}/share/kxmlgui5/labplot2/labplot2ui.rc" "#{prefix}/bin/labplot2.app/Contents/Resources/labplot2ui.rc"
       ln -sf "#{prefix}/bin/labplot2.app" "/Applications/"
    EOS
  end
end