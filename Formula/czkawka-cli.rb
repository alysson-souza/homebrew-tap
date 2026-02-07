class CzkawkaCli < Formula
  desc "Command-line tool to find duplicates, empty folders, similar images, etc."
  homepage "https://github.com/qarmin/czkawka"
  head "https://github.com/qarmin/czkawka.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "czkawka_cli")
  end

  test do
    system "#{bin}/czkawka_cli", "--help"
  end
end
