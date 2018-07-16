class Cantor < Formula
  desc "KDE Frontend to Mathematical Software"
  homepage "https://kde.org/applications/education/cantor/"
  url "http://download.kde.org/stable/applications/18.04.3/src/cantor-18.04.3.tar.xz"
  sha256 "8cae8508ed8bdcd092de9db98ba1fdd9718fee06aa3008abd62bf09625dba847"

  head "git://anongit.kde.org/cantor.git"

  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "python" => :build
  depends_on "python2" => :build
  depends_on "luajit" => :build
  depends_on "r" => :build
  #depends_on "staticfloat/julia/julia" => :build
  # Resolve cask dependencies for julia
  system "/usr/local/bin/brew", "cask", "install", "julia"
  #depends_on cask: 'julia' => :build
    
  depends_on "analitza"
  depends_on "libspectre"
  depends_on "KDE-mac/kde/kf5-kpty"
  depends_on "KDE-mac/kde/kf5-ktexteditor"
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "libqalculate"
  depends_on "hicolor-icon-theme"

  depends_on "maxima" => :optional
  depends_on "octave" => :optional
  # Resolve cask dependencies for sage
  system "/usr/local/bin/brew", "cask", "install", "sage"
  #depends_on "homebrew/cask/sage" => :optional
        
  def install
    args = std_cmake_args
    #args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    #args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
    args << "-DCMAKE_INSTALL_BUNDLEDIR=#{bin}"
    args << "-DBUILD_TESTING=OFF"
    #args << "-DCMAKE_BUILD_TYPE=Release"
    #args << "-DBUILD_QT5=ON"
    #args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    #args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    #args << "-DKDE_INSTALL_USE_QT_SYS_PATHS=ON"
    args << "-DCMAKE_PREFIX_PATH=" + Formula["qt"].opt_prefix + "/lib/cmake"
    #args << "-DQt5WebKitWidgets_DIR=" + Formula["qt-webkit"].opt_prefix + "/lib/cmake/Qt5WebKitWidgets"
    #args << "-DPYTHON_EXECUTABLE=#{Formula["python@2"].bin}/python"
    args << "-DPYTHON_LIBRARY=#{Formula["python@2"].frameworks}/Python.framework/Versions/2.7/lib/libpython2.7.dylib"
    args << "-DPYTHON_INCLUDE_DIR=#{Formula["python@2"].frameworks}/Python.framework/Versions/2.7/include/python2.7"
      
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
end