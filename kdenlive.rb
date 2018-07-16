class Kdenlive < Formula
  desc "A non-linear video editor for Linux using the MLT video framework"
  homepage "https://www.kdenlive.org/"
  #url "https://download.kde.org/stable/applications/18.04.3/src/kdenlive-18.04.3.tar.xz"
  #sha256 "9505ac2e5f4918932b868f0ccc1d74b1ae545283033081fab92415cc0d1d435f"
    
  url "https://github.com/fjperini/kdenlive.git", :branch => "master"
  version "2.5.0"
    
  head "git://anongit.kde.org/kdenlive.git"
  
  depends_on "cmake" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
             #v4l-utils
  depends_on "KDE-mac/kde/kf5-knewstuff"
  depends_on "KDE-mac/kde/kf5-knotifyconfig"
  depends_on "KDE-mac/kde/kf5-kfilemetadata"
  depends_on "KDE-mac/kde/qt-webkit"
  depends_on "mlt"
  #glu
  #qt5-quickcontrols
  depends_on "ffmpeg" => :optional
  depends_on "libdv" => :optional
  depends_on "cdrtools" => :optional
  depends_on "dvdauthor" => :optional
              #dvgrab
              #recordmydesktop
              #xine-ui
  #depends_on cask: 'vlc' => :optional

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
      
    #args << "-DUSE_V4L=OFF"
    #args << "-DUSE_KF5_PURPOSE=OFF"
      
    #translations
    #make fetch-translations
    #cd ..
    #ln -s build/po/ po
    #cd build/
    #Then build and install:
    #make -j5
    #make install
      
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end
    
  def post_install
    mkdir_p HOMEBREW_PREFIX/share/kdenlive
    ln_sf HOMEBREW_PREFIX/share/icons/breeze/breeze-icons.rcc, HOMEBREW_PREFIX/share/kdenlive/icontheme.rcc
  end
    
  def caveats; <<~EOS
    You need to take some manual steps in order to make this formula work:
       ln -sfv "$(brew --prefix)/share/kdenlive" "$HOME/Library/Application Support"
       ln -sfv "#{prefix}/share/kxmlgui5/kdenlive/kdenlive.rc" "#{prefix}/bin/kdenlive.app/Contents/Resources/kdenlive.rc"
       ln -sfv "#{prefix}/bin/kdenlive.app" "/Applications/"
    EOS
  end
end