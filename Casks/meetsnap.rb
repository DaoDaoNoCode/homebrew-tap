cask "meetsnap" do
  version "1.0"
  sha256 "cd607e9340e7bcdfda98f8573a001b3b46b5336e4ca26ae6688d582a09343be8"

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
