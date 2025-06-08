class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.4.1-alpha.4.tar.gz"
  sha256 "d0ebf9269e321c57871bc4a627670c086a659c48ed70e4a70ee8cf4854f4d2b5"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.4.1-alpha.4"
    sha256 arm64_sequoia: "c5fc95c62f7d90d04d86bb962cfcb34726ae3a5de2d0cf2577320f4621a86e2f"
    sha256 arm64_sonoma:  "85d1259d830d7f3ee241c7429d21c705a507bddcf7fc9f6fbbac303f1802fc7e"
    sha256 ventura:       "18475454fbf01e92d9137ab547b5ec51ed956bc35e5f3ca8b4726fd5f0fd67e3"
  end

  depends_on "dub" => :build
  depends_on "ldc" => :build
  depends_on "libpq"
  depends_on "libzip"
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
