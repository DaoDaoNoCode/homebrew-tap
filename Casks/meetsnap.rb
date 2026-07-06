cask "meetsnap" do
  version "1.0"
  sha256 "d9ac5eea545c0ce7055c62d828fb63defa94f531bfa5e9d9c8f8cca9ecb0de94"

  url "https://github.com/DaoDaoNoCode/MeetSnap/releases/download/v#{version}/MeetSnap-#{version}.zip"
  name "MeetSnap"
  desc "One-click menu bar app to switch back to your active Google Meet tab"
  homepage "https://github.com/DaoDaoNoCode/MeetSnap"

  depends_on macos: ">= :ventura"

  app "MeetSnap.app"

  zap trash: [
    "~/Library/Preferences/com.meetsnap.app.plist",
  ]
end
