class Odood < Formula
  desc "Manage local development odoo installations with ease"
  homepage "https://katyukha.github.io/Odood/"
  url "https://github.com/katyukha/Odood/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "c6b4ce396e5284b97cd9fb4fc2e0e3e003a575708dbe48b9aa651240059c243b"
  license "MPL-2.0"

  depends_on "dub" => :build
  depends_on "ldc" => :build
  depends_on "libpq"
  depends_on "libzip"
  depends_on "python3"

  def install
    File.write("./subpackages/lib/data/ODOOD_VERSION", version)
    system "dub", "build", "--build=release-debug"
    system "dub", "build", "--build=release-debug", "--config=bash-autocomplete"
    bin.install "./build/odood"
    bash_completion.install "./build/odood.bash"
  end

  test do
    system "#{bin}/odood", "--version"
    system "#{bin}/odood", "init", "-v", "18", "-i", "odood-18"
    # TODO: Add some real tests (for example create instance and remove it)
  end
end
