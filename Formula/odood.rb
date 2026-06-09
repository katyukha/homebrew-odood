class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.6.3.tar.gz"
  sha256 "9fbe6cd01ef794d0746d5c7d2fae04e603508b9f002e44a3ac06598cbb05005d"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.6.3"
    sha256               arm64_sequoia: "a805353d4892e70068fab87570c4c8f65ddb612ec680b9f390c1f3cbfae528f4"
    sha256               arm64_sonoma:  "1778cb5743bfc62a9de71df302203a08bcb803195f5ac1bd0cfdb84626cbc799"
    sha256 cellar: :any, x86_64_linux:  "2848e449837050453cf7c45ce242590815276e64ca2fbaad24b4695df49e4bda"
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
