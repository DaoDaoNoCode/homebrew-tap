class Meetsnap < Formula
  desc "One-click menu bar app to switch back to your active Google Meet tab"
  homepage "https://github.com/DaoDaoNoCode/MeetSnap"
  url "https://github.com/DaoDaoNoCode/MeetSnap/archive/refs/tags/v1.0.tar.gz"
  sha256 :no_check
  license "MIT"

  depends_on :macos
  depends_on macos: :ventura
  depends_on :xcode => ["15.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/MeetSnap"

    # Create .app bundle
    app_dir = prefix/"MeetSnap.app/Contents"
    (app_dir/"MacOS").mkpath
    (app_dir/"Resources").mkpath

    cp bin/"MeetSnap", app_dir/"MacOS/MeetSnap"
    cp "Resources/Info.plist", app_dir/"Info.plist"

    # Generate app icon
    system "swift", "generate_icon.swift", buildpath.to_s
    if File.exist?("icon_1024.png")
      iconset = buildpath/"MeetSnap.iconset"
      iconset.mkpath
      system "sips", "-z", "16", "16", "icon_1024.png", "--out", "#{iconset}/icon_16x16.png"
      system "sips", "-z", "32", "32", "icon_1024.png", "--out", "#{iconset}/icon_16x16@2x.png"
      system "sips", "-z", "32", "32", "icon_1024.png", "--out", "#{iconset}/icon_32x32.png"
      system "sips", "-z", "64", "64", "icon_1024.png", "--out", "#{iconset}/icon_32x32@2x.png"
      system "sips", "-z", "128", "128", "icon_1024.png", "--out", "#{iconset}/icon_128x128.png"
      system "sips", "-z", "256", "256", "icon_1024.png", "--out", "#{iconset}/icon_256x256.png"
      system "sips", "-z", "256", "256", "icon_1024.png", "--out", "#{iconset}/icon_128x128@2x.png"
      system "sips", "-z", "512", "512", "icon_1024.png", "--out", "#{iconset}/icon_256x256@2x.png"
      system "sips", "-z", "512", "512", "icon_1024.png", "--out", "#{iconset}/icon_512x512.png"
      cp "icon_1024.png", "#{iconset}/icon_512x512@2x.png"
      system "iconutil", "-c", "icns", iconset.to_s, "-o", "#{app_dir}/Resources/AppIcon.icns"
    end

    # Link .app to /Applications
    (HOMEBREW_PREFIX/"bin/meetsnap-link").write <<~SH
      #!/bin/bash
      ln -sf "#{prefix}/MeetSnap.app" "/Applications/MeetSnap.app"
      echo "MeetSnap.app linked to /Applications"
    SH
    (HOMEBREW_PREFIX/"bin/meetsnap-link").chmod 0755
  end

  def post_install
    ln_sf prefix/"MeetSnap.app", "/Applications/MeetSnap.app"
  end

  def caveats
    <<~EOS
      MeetSnap.app has been linked to /Applications.
      Open it from Applications or Spotlight to start.

      To unlink: rm /Applications/MeetSnap.app
    EOS
  end

  test do
    assert_predicate prefix/"MeetSnap.app/Contents/MacOS/MeetSnap", :exist?
  end
end
