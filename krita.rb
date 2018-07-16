class Krita < Formula
  desc "Edit and paint images"
  homepage "https://krita.org/"
  url "https://download.kde.org/stable/krita/4.1.1/krita-4.1.1.tar.gz"
  sha256 "5cab10343f97a9944a1ab2e137cd0ade6029ce157118009660af286eb75ce9e3"
    
  head "git://anongit.kde.org/krita.git"

  # makedepends
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "boost"
  depends_on "eigen"
  #vc
  #system "/usr/local/bin/brew", "reinstall", "poppler", "--with-qt"    
  #depends_on "poppler" #poppler-qt5
  depends_on "opencolorio"
  depends_on "pyqt" # python-pyqt5
  depends_on "libheif"
  depends_on "sip"
  #python-sip
  
  # depends
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "kf5-kitemmodels"
  depends_on "gsl"
  depends_on "libraw"
  depends_on "exiv2"
  depends_on "openexr"
  depends_on "fftw"
  depends_on "curl"
  #boost-libs
  depends_on "giflib"
  #qt5-declarative
  depends_on "hicolor-icon-theme"

  # optdepends
  depends_on "ffmpeg" => :optional
  #krita-plugin-gmic
    
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
    mkdir_p HOMEBREW_PREFIX/share/krita
    ln_sf HOMEBREW_PREFIX/share/icons/breeze/breeze-icons.rcc, HOMEBREW_PREFIX/share/krita/icontheme.rcc
  end
    
  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
       ln -sfv "#{prefix}/share/kxmlgui5/kdenlive/krita.rc" "#{prefix}/bin/krita/Contents/Resources/krita.rc"
       ln -sfv "#{prefix}/bin/krita.app" "/Applications/"
    EOS
  end
end