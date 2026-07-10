class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.6.4.tar.gz"
  sha256 "4efdfbd34c5addce486e5e77e610164227767f40470443aa3ab1f59bd1c4a5ad"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.6.4"
    sha256               arm64_sequoia: "ddab45f86004e96f3b55fa84b670d33205a3f678250fc3b57d44bf9d34e46bd0"
    sha256               arm64_sonoma:  "6f84aa13a205134d32d14fa61e5ccb86565ca07da4ae5b3d569432b092c779fe"
    sha256 cellar: :any, x86_64_linux:  "7e22e6d328df2dca000ff407f1d74840cafb0e6e787897d83f4cbb15358a2667"
  end

  depends_on "dub" => :build
  depends_on "ldc" => :build
  depends_on "libpq"
  depends_on "openldap"
  depends_on "openssl@3"
  depends_on "pyenv"
  depends_on "python@3.13"

  uses_from_macos "openldap"

  def install
    File.write("./subpackages/lib/data/ODOOD_VERSION", version)
    system "dub", "build", "--build=release-debug"
    bin.install "./build/odood"

    system "dub", "build", "--build=release-debug", "--config=bash-autocomplete"
    bash_completion.install "./build/odood.bash"
  end

  test do
    system "#{bin}/odood", "--version"
    system "#{bin}/odood", "--help"
    # system "#{bin}/odood", "init", "-v", "18", "-i", "odood-18", "--pyenv"
    # TODO: Add some real tests (for example create instance and remove it)
  end
end
