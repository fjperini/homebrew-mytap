class Krename < Formula
  desc "A very powerful batch file renamer"
  homepage "http://www.krename.net/"
  url "https://download.kde.org/stable/krename/5.0.0/src/krename-5.0.0.tar.xz"
  sha256 "0a61761853787fd46b35f3a733cf87cde00de5df631728332a64c38c670bd28c"

  head "git://anongit.kde.org/krename.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
    
  depends_on "KDE-mac/kde/kf5-kio"
  depends_on "KDE-mac/kde/kf5-kjs"
  depends_on "exiv2"
  depends_on "podofo"
  depends_on "taglib"
  depends_on "hicolor-icon-theme"
      
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
end