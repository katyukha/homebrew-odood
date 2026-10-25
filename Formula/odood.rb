class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "8ab13ffa462b48aef3095ff08de7a5d805ad74c83ed88107d129f2996a985e02"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.7.0"
    sha256               arm64_tahoe:   "fe1ae135f24d91c530e170216b6101d86d03cb4687b544871f91c1d6af604fbd"
    sha256               arm64_sequoia: "0d7da55b1bf7aa58693230683d73c43c05ddf5635451828b14990ccf2de918a0"
    sha256 cellar: :any, x86_64_linux:  "70f5918fe624ab51036400fd5092e94720ebacdc8ac30677657f129af8fcef82"
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
