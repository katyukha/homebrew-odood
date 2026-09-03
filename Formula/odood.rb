class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.6.5.tar.gz"
  sha256 "6783653fab5d0bd8937352e009f696af83c173c93e0b780d3fb1f284b5d72fed"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.6.5"
    sha256               arm64_sequoia: "6c697fc62ff0d0d2fa4c12b154cfad25a3da85e02817a5fda6fa0e1c1c7a742f"
    sha256               arm64_sonoma:  "62b855e99ad8afb758b17c7bfa908b029a599bb8c81b70cb6ab5e5ae17663886"
    sha256 cellar: :any, x86_64_linux:  "729646baf5ee7607d05be66932948f54a21b9eb32144bf87d61849d9051b6068"
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
