class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.5.5.tar.gz"
  sha256 "d001bbf037c67c9a02de33b78ca37163fa8119f686135a556f528ee3eabe3a95"
  license "MPL-2.0"

  bottle do
    root_url "https://github.com/katyukha/homebrew-odood/releases/download/odood-0.5.5"
    sha256                               arm64_sequoia: "1d9a5907ae47e40eb6346efca5ead4ad4318f984a97139427a81677291000862"
    sha256                               arm64_sonoma:  "961dece2abe0ede31492ff317baace59c771a1b3d8472eaf21e1138192b732a8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "51cb9663a6a4c6ac9d3e21a1832460f8f4dda7ae88202b9ec3d393a4b30a28a8"
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
