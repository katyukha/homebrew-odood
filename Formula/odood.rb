class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.4.3.tar.gz"
  sha256 "b5f4c4a9ae3d29d3a988bdf00d6e5de1b5630e406f7944f4ce44e8779d87ec34"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.4.2"
    sha256                               arm64_sequoia: "c6939e84c65e694342d0a6c00652be05a357607cdbb9981c0ca68c2ce61941c8"
    sha256                               arm64_sonoma:  "beb1d0f62c0875f27005669137e21ea542b27304a14a083434f943a3ccedd827"
    sha256                               ventura:       "19af3fba5c0fa6fc9b416482897e739bbaffa4aa966a0c8cfe32dedf4e1da9db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1b552a67d3e4cf172ca5f1c82d23b3fc1e7b0c08e2e3dddd7fe36f5dbcd9074"
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
