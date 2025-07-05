class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "b5f4c4a9ae3d29d3a988bdf00d6e5de1b5630e406f7944f4ce44e8779d87ec34"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.4.3"
    sha256                               arm64_sequoia: "cf08b7248ca2488b39aaab64c0f9106479f9e3c28169d5a0522274dcf86442be"
    sha256                               arm64_sonoma:  "4c454682785a5a6f5703cf42e6c0e0f427b8b4976ed346bae606d6251e189046"
    sha256                               ventura:       "78b563a03da3c0556a8d7edbc39d02897584ab1b2c07d4a9ac7b53b87b85e5be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1ac2d5de4792446d59f1bc8b0b7993d174f7bc403ae7c6a865604ed289383ecd"
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
