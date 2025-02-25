class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.2.2-rc.1.tar.gz"
  sha256 "99b02843200adcd9c7dcada1dd8326e07c17d1d5c26c5782dedab6ed935c11ea"
  license "MPL-2.0"

  depends_on "ldc" => :build
  depends_on "dub" => :build
  depends_on "libpq"
  depends_on "libzip"
  depends_on "python3"

  def install
    system "dub", "build", "--build=release"
    system "dub", "build", "--build=release", "--config=bash-autocomplete"
    bin.install "./build/odood"
    bash_completion.install "./build/odood.bash"
  end

  test do
    system "odood" "--version"
    # TODO: Add some real tests (for example create instance and remove it)
  end
end

