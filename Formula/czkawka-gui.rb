class CzkawkaGui < Formula
  desc "GTK4 GUI application to find duplicates, similar images, and more"
  homepage "https://github.com/qarmin/czkawka"
  head "https://github.com/qarmin/czkawka.git", branch: "master"

  depends_on "rust" => :build
  depends_on "gtk4"
  depends_on "libadwaita"

  def install
    system "cargo", "install", *std_cargo_args(path: "czkawka_gui")
  end

  test do
    system "#{bin}/czkawka_gui", "--help"
  end
end
