class Molequeue < Formula
  desc "Desktop integration of high performance computing resources"
  homepage "http://openchemistry.org/"
  url "https://github.com/OpenChemistry/molequeue/archive/0.9.0.tar.gz"
  sha256 "7dd234742c8d73be95281fedf4ed9d09648ecc351afb5f098cd32f48c3df3bd5"

  head "git://github.com/OpenChemistry/molequeue.git"
   
  # makedepends
  depends_on "cmake" => :build
    
  # depends
  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    #args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    #args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    #args << "-DBUILD_TESTING=OFF"
    #args << "-DCMAKE_BUILD_TYPE=Release"
    #args << "-DBUILD_QT5=ON"
    #args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    #args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    #args << "-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
    #args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"
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