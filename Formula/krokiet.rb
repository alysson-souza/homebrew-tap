class Krokiet < Formula
  desc "Modern GUI application to find duplicates, similar images, and more"
  homepage "https://github.com/qarmin/czkawka"
  head "https://github.com/qarmin/czkawka.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "krokiet")

    # Create macOS app bundle
    app_name = "Krokiet"
    app_bundle = "#{app_name}.app"
    bin_name = "krokiet"

    # Build the app bundle structure
    mkdir_p "#{app_bundle}/Contents/MacOS"
    mkdir_p "#{app_bundle}/Contents/Resources"

    # Copy binary
    cp "#{bin}/#{bin_name}", "#{app_bundle}/Contents/MacOS/#{bin_name}"

    # Create Info.plist
    ("#{app_bundle}/Contents/Info.plist").write <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>CFBundleDevelopmentRegion</key>
          <string>en</string>
          <key>CFBundleExecutable</key>
          <string>#{bin_name}</string>
          <key>CFBundleIdentifier</key>
          <string>com.github.qarmin.krokiet</string>
          <key>CFBundleInfoDictionaryVersion</key>
          <string>6.0</string>
          <key>CFBundleName</key>
          <string>#{app_name}</string>
          <key>CFBundlePackageType</key>
          <string>APPL</string>
          <key>LSMinimumSystemVersion</key>
          <string>10.11</string>
          <key>NSHighResolutionCapable</key>
          <true/>
      </dict>
      </plist>
    EOS

    # Install the app bundle to Applications
    prefix.install app_bundle

    # Create a symlink in bin for command-line access
    bin.install_symlink prefix/"#{app_bundle}/Contents/MacOS/#{bin_name}"
  end

  def caveats
    <<~EOS
      Krokiet.app has been installed to:
        #{opt_prefix}/Krokiet.app

      To use it, you can:
        1. Run from command line: krokiet
        2. Copy to Applications: cp -r #{opt_prefix}/Krokiet.app /Applications/
    EOS
  end

  test do
    system "#{bin}/krokiet", "--help"
  end
end
