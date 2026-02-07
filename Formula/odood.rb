class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.5.4.tar.gz"
  sha256 "672cd11c4509b68de0dce67985a8699df110f5bacb496c4a6fc5a87937331ad3"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.5.4"
    sha256                               arm64_sequoia: "453cf2d1c3ac59259cb1cec517ed683d588e181f7b203635df5390d04f0d4023"
    sha256                               arm64_sonoma:  "9bdc0c011eff46e4266c270f9c73cd6ec44ac1490dc1034190b842071797462f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ee6b37051d2a78319a93c531966801f1ebe67a2be01665716eeb53737710e7b9"
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
