class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "928d8ac65fd33746e1a4e07358898627188bfdb1a6a9589e67d8d1ec7bc2688c"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.5.3"
    sha256                               arm64_sequoia: "fcbf27794d4dd95f863a1eabf8c8b0605298df85d9adcfae354f45a5e35875c6"
    sha256                               arm64_sonoma:  "dedc6d24792e094fa31a0743cdbeffa50a26f56bad8b8f9dcaf7876f32a49661"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2814aba53f5a7f1ac748262a2fb0ae7c19a20bce2d5f6a7fc87b37fc0c054553"
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
