class ArcaneFramework < Formula
  desc "HPC framework for numerical simulations"
  homepage "https://github.com/arcaneframework/framework"
  head "https://github.com/arcaneframework/framework.git", branch: "main", using: :git, shallow: false

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "gcc"
  depends_on "open-mpi"
  depends_on "hdf5-mpi"
  depends_on "scotch"
  depends_on "petsc"
  depends_on "mohd-afeef-badri/arcaneframework/hypre-int32"
  depends_on "zstd"
  depends_on "dotnet" => :optional

  fails_with :clang do
    cause "Arcane Framework requires GCC for compilation"
  end

  def install
    # Ensure GCC is used
    ENV["CC"] = "gcc-15"
    ENV["CXX"] = "g++-15"
    ENV["OMPI_MCA_rmaps_base_oversubscribe"] = "true"
    ENV.append "CXXFLAGS", "-Wno-error"

    args = %W[
      -DCMAKE_VERBOSE_MAKEFILE=TRUE
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DARCANEFRAMEWORK_BUILD_COMPONENTS=Arcane
      -DARCCORE_CXX_STANDARD=20
      -DCMAKE_CXX_COMPILER=g++-15
      -DCMAKE_C_COMPILER=gcc-15
      -DARCANE_ENABLE_DOTNET_WRAPPER=OFF
      -DCMAKE_DISABLE_FIND_PACKAGE_VTK=TRUE
      -G Ninja
    ]

    # Enable dotnet wrapper if dotnet is available
    args << "-DARCANE_ENABLE_DOTNET_WRAPPER=ON" if build.with? "dotnet"

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build", "--parallel"
    system "cmake", "--install", "build"
  end
end
