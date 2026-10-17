cask "androidft" do
  version "0.1.1"
  sha256 "cf70638375a72fa01defab1b4922522a1fa80fc150afaa70d626a46e5925ae0c"

  url "https://github.com/rajpdus/androidft/releases/download/v#{version}/AndroidFT-#{version}.zip"
  name "AndroidFT"
  desc "Native Apple Silicon file transfer app for Android phones (MTP)"
  homepage "https://github.com/rajpdus/androidft"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "AndroidFT.app"

  # The app is signed ad hoc (no Apple Developer ID); without this Gatekeeper
  # refuses to open the downloaded copy.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/AndroidFT.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.rajpdus.androidft.plist",
    "~/Library/Saved Application State/com.rajpdus.androidft.savedState",
  ]

  caveats <<~EOS
    If Google's Android File Transfer is installed, quit it and remove its
    "Android File Transfer Agent" login item (System Settings > General >
    Login Items): it grabs the phone's USB interface as soon as a device is
    plugged in, which blocks AndroidFT.
  EOS
end
