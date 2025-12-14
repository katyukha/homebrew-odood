class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "858e072a56ac0af44ae4f7ea25a3212a0e6896f9149968c850e714aef9868c9d"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.5.1"
    sha256                               arm64_sequoia: "9af3f7648a148c36c79f69636d468c411fcda1f956b4da9c2be362800bc11df2"
    sha256                               arm64_sonoma:  "a822f186d65fc2334d96b2815ff8fa7bbdc20d7efd3e08d3ce0377bc04ed66b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e96b81d907edda35adfd044d0f1e016a558351809492dc1cf4b4ec7ee3a5cbf"
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
