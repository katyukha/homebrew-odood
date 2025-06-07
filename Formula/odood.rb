class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.4.1-alpha.3.tar.gz"
  sha256 "457f598fa17490c7a560f7184cd92e1478e8908aca552e529fb8663b1e8cd4bd"
  license "MPL-2.0"

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

    # Autocomplete post-build commands does not work
    # TODO: Maybe build it via separate job
    # system "dub", "build", "--build=release-debug", "--config=bash-autocomplete"
    # bash_completion.install "./build/odood.bash"
  end

  test do
    system "#{bin}/odood", "--version"
    system "#{bin}/odood", "init", "-v", "18", "-i", "odood-18", "--pyenv"
    # TODO: Add some real tests (for example create instance and remove it)
  end
end
