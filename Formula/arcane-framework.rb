class ArcaneFramework < Formula
  desc "HPC framework for numerical simulations"
  homepage "https://github.com/arcaneframework/framework"
  url "https://github.com/arcaneframework/framework/archive/fdded890205c920bfb1e3f3df471627b3ad154a6.tar.gz"
  sha256 "3a2be6a217d3e27bc8aa1d43976b1336474bba1583ab1b26311ac702a846b64a"
  license "Apache-2.0"
  head "https://github.com/arcaneframework/framework", branch: "main", submodules: true

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "gcc"
  depends_on "open-mpi"
  depends_on "hdf5-mpi"
  depends_on "scotch"
  depends_on "petsc"
  depends_on "zstd"
  depends_on "dotnet" => :optional

  # Ensure gcc using the right compiler
  fails_with :clang do
    cause "Arcane Framework requires GCC for compilation"
  end

  def install
    # Set up environment similar to CI
    ENV["CC"] = "gcc-15"
    ENV["CXX"] = "g++-15"
    ENV["OMPI_MCA_rmaps_base_oversubscribe"] = "true"

    # Configure the build
    args = %W[
      -DCMAKE_VERBOSE_MAKEFILE=TRUE
      -DCMAKE_INSTALL_PREFIX=#{prefix}
      -DARCANEFRAMEWORK_BUILD_COMPONENTS=Arcane
      -DARCCORE_CXX_STANDARD=20
      -DCMAKE_CXX_COMPILER=g++-15
      -DCMAKE_C_COMPILER=gcc-15
      -DARCANE_ENABLE_DOTNET_WRAPPER=OFF
      -DCMAKE_DISABLE_FIND_PACKAGE_Hypre=TRUE
      -G Ninja
    ]

    # Enable dotnet wrapper if dotnet is available
    if build.with?("dotnet")
      args << "-DARCANE_ENABLE_DOTNET_WRAPPER=ON"
    end

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

end
