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
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DBUILD_TESTING=OFF"
    args << "-DCMAKE_BUILD_TYPE=Release"
    #args << "-DBUILD_QT5=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    #args << "-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"
    #args << "-DQt5WebKitWidgets_DIR=" + Formula["qt-webkit"].opt_prefix + "/lib/cmake/Qt5WebKitWidgets"
    #args << "-DPYTHON_EXECUTABLE=#{Formula["python@2"].bin}/python"
    #args << "-DPYTHON_LIBRARY=#{Formula["python@2"].frameworks}/Python.framework/Versions/2.7/lib/libpython2.7.dylib"
    #args << "-DPYTHON_INCLUDE_DIR=#{Formula["python@2"].frameworks}/Python.framework/Versions/2.7/include/python2.7"
      
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
       ln -sfv "#{prefix}/share/kxmlgui5/labplot/labplot2ui.rc" "#{prefix}/bin/labplot2.app/Contents/Resources/labplot2ui.rc"
       ln -sfv "#{prefix}/bin/labplot2.app" "/Applications/"
    EOS
  end
end