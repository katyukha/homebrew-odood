class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "a957fb598e51b0161506f0cf51c2443592aed1caf59efa00dd90e33e2957b333"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.5.2"
    sha256                               arm64_sequoia: "3b3c4a9100fd59790d2e17c2d7fdb61ee39ba61de4492dc8e5ffd7d168de9795"
    sha256                               arm64_sonoma:  "bebdc0cc801d0b4908384ce7ab26ea6303e45a6ae3a632dc946151676c805f49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b43ef1584869f810656163066f23e51dd33b537cfb1b9a013644e27d0ce397d8"
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
