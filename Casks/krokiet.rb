cask "krokiet" do
  version :latest
  sha256 :no_check

  url "https://github.com/alysson-souza/homebrew-tap/releases/latest/download/Krokiet-macos.dmg",
      verified: "github.com/alysson-souza/homebrew-tap/"
  name "Krokiet"
  desc "Modern GUI application to find duplicates, similar images, and more"
  homepage "https://github.com/qarmin/czkawka"

  livecheck do
    url "https://api.github.com/repos/alysson-souza/homebrew-tap/releases/latest"
    strategy :json do |json|
      json["tag_name"]
    end
  end

  auto_updates true

  app "Krokiet.app"

  zap trash: [
    "~/Library/Application Support/pl.Qarmin.Krokiet",
    "~/Library/Caches/pl.Qarmin.Czkawka",
    "~/.config/krokiet",
  ]
end
