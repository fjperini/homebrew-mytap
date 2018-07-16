class Avogadrolibs < Formula
  desc "Libraries that provide 3D rendering, visualization, analysis and data processing useful in computational chemistry, molecular modeling, bioinformatics, materials science, and related areas"
  homepage "http://www.openchemistry.org/"
  url "https://github.com/OpenChemistry/avogadrolibs/archive/1.90.0.tar.gz"
  sha256 "a562acae129901cb2c9878f5ca4cc8874a8a04260b93a700489dc85dc862c9b7"

  head "git://github.com/OpenChemistry/avogadrolibs.git"

  #patch do
  # url ""
  # sha256 ""
  #end

  # makedepends
  depends_on "cmake" => :build
  depends_on "eigen" => :build
  depends_on "python@2" => :build
  depends_on "boost" => :build

  # depends
  depends_on "molequeue"
  depends_on "glew"
  depends_on "spglib"

    #libarchive
    #glew
    #hdf5
    #vtk
    #libmsym
    #spglib
    #qt5-webview
    #qt5-x11extras
    #molequeue
    #python
    #pybind11
    #    
    #git
    #cmake
    #eigen
    #gtest
    #gdal
    #openmpi
    
  def install
    args = std_cmake_args
    args << "-DCMAKE_INSTALL_PREFIX=#{prefix}"
    args << "-DCMAKE_INSTALL_LIBDIR=#{lib}"
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
      
    args << "-DUSE_PROTOCALL=OFF"
	#args << "-DBUILD_GPL_PLUGINS=ON"
	args << "-DUSE_MOLEQUEUE=ON"
	args << "-DUSE_LIBMSYM=ON"
	args << "-DUSE_LIBSPG=ON"
	args << "-DUSE_PYTHON=ON"
	args << "-DUSE_LIBARCHIVE=ON"
	#args << "-DBUILD_DOCUMENTATION="
	#args << "-DENABLE_TRANSLATIONS="
	#args << "-DBUILD_STATIC_PLUGINS=ON"
      
    args << "-DBUILD_SHARED_LIBS=OFF"
    args << "-DUSE_OPENGL=ON"
    args << "-DUSE_HDF5=OFF"
    args << "-DUSE_QT=ON"
    #args << "-DUSE_VTK=OFF"
    #args << "-DPYTHON_EXECUTABLE=#{Formula["python"].bin}/python"
      
    args << "-DSPGLIB_INCLUDE_DIRS=/usr/local/Cellar/spglib/1.10.3/include/spglib/"
    args << "-DSPGLIB_LIBRARY=/usr/local/Cellar/spglib/1.10.3/lib/libsymspg.dylib"
      
    # Find spglib
    #sed -e 's|NAMES spglib|NAMES spglib symspg|' -i cmake/FindSpglib.cmake
    #system "sed -e 's|NAMES spglib|NAMES spglib symspg|' cmake/FindSpglib.cmake"
    # Fix build with GCC>=7
    #system "sed -e 's|3456|3456789|' cmake/GenerateExportHeader.cmake"
    # sed -e 's|3456|3456789|' -i cmake/GenerateExportHeader.cmake
      
    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
    # post-install
    # rm "$pkgdir"/usr/lib/libjsoncpp.a # provided by jsoncpp
  end
end
 
