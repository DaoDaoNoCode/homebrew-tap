cask "meetsnap" do
  version "1.0"
  sha256 "60cd8f10b159f2063696348a146bcc303d210a3fbeb04d7bad1ef1e32e167045"

  url "https://github.com/DaoDaoNoCode/MeetSnap/releases/download/v#{version}/MeetSnap-#{version}.dmg"
  name "MeetSnap"
  desc "One-click menu bar app to switch back to your active Google Meet tab"
  homepage "https://github.com/DaoDaoNoCode/MeetSnap"

  depends_on macos: ">= :ventura"

  app "MeetSnap.app"

  zap trash: [
    "~/Library/Preferences/com.meetsnap.app.plist",
  ]
end
