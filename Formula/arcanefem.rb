class ArcaneFem < Formula
  desc "HPC finite element solver"
  homepage "https://github.com/arcaneframework/arcanefem"
  head "https://github.com/arcaneframework/arcanefem.git", branch: "main", using: :git, shallow: false

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
  depends_on "mohd-afeef-badri/arcaneframework/arcane-framework"


  fails_with :clang do
    cause "Arcanefem requires GCC for compilation"
  end

  def install
    # Ensure GCC is used
    ENV["CC"] = "gcc-15"
    ENV["CXX"] = "g++-15"
    ENV["OMPI_MCA_rmaps_base_oversubscribe"] = "true"
    ENV.append "CXXFLAGS", "-Wno-error"

    args = %W[
      -DCMAKE_VERBOSE_MAKEFILE=TRUE
      -DCMAKE_BUILD_TYPE=Release
      -DCMAKE_CXX_COMPILER=g++-15
      -DCMAKE_C_COMPILER=gcc-15
      -G Ninja
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build", "--parallel"
  end
end
