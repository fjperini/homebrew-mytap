class Analitza < Formula
  desc "A library to add mathematical features to your program"
  homepage "https://edu.kde.org/"
  url "https://download.kde.org/stable/applications/18.04.3/src/analitza-18.04.3.tar.xz"
  sha256 "aef8f3f46ed35294b857d26419cc0affc568e97990448cccfd4f71c492046afb"

  head "git://anongit.kde.org/analitza.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "eigen" => :build
      
  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    #args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DBUILD_TESTING=OFF"
    #args << "-DCMAKE_BUILD_TYPE=Release"
    #args << "-DBUILD_QT5=ON"
    #args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    #args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
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