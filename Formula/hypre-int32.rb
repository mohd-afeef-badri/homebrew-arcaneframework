# Formula/hypre-int32.rb
# Sadly the offical formula on homebrew-core/Formula is int64
# This one is copied and modified for int32
class HypreInt32 < Formula
  desc "Library featuring parallel multigrid methods for grid problems"
  homepage "https://computing.llnl.gov/projects/hypre-scalable-linear-solvers-multigrid-methods"
  url "https://github.com/hypre-space/hypre/archive/refs/tags/v2.33.0.tar.gz"
  sha256 "0f9103c34bce7a5dcbdb79a502720fc8aab4db9fd0146e0791cde7ec878f27da"
  license any_of: ["MIT", "Apache-2.0"]
  revision 1
  head "https://github.com/hypre-space/hypre.git", branch: "master"

  bottle :disabled, "Custom 32-bit integer build"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build
  depends_on "gcc"
  depends_on "open-mpi"
  depends_on "openblas"

  def install
    system "cmake", "-S", "src", "-B", "build",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DHYPRE_ENABLE_BIGINT=OFF",
                    "-DHYPRE_ENABLE_HYPRE_BLAS=OFF",
                    "-DHYPRE_ENABLE_HYPRE_LAPACK=OFF",
                    "-DHYPRE_ENABLE_MPI=ON",
                    *std_cmake_args
    system "cmake", "--build", "build", "--parallel"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "HYPRE_struct_ls.h"
      int main(int argc, char* argv[]) {
        HYPRE_StructGrid grid;
      }
    CPP

    system ENV.cxx, "test.cpp", "-o", "test"
    system "./test"
  end
end
