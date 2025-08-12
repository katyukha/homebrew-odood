class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.4.4.tar.gz"
  sha256 "c5713cb51ad3063419a05711ae3bf0b36944d30db5fca353cbca2e4f97cb56a9"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.4.4"
    sha256                               arm64_sequoia: "4c8019809d019eb4a85ef3190463f435b8c4923f93fe892614c3d40b6cd2b2e0"
    sha256                               arm64_sonoma:  "6f7e5312482fb36afc730b5c0d16322f42ae4baff0c64a9cd8d5ca47648a98bf"
    sha256                               ventura:       "4160b2ef2fcde99fcf59b6e84d8470510e8438402e11dab6b1c0dc8bf1f4fac7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ccf68c32fd837208b309eae56dd9c77708d50fe3fc70f9c2fb79dd1beeae9b8"
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
