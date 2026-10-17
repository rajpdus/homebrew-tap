cask "androidft" do
  version "0.1.2"
  sha256 "ab6dc42da8a3e673ad0e5002d831c5e7abf74ff92a4bc0ed1051969dbe0df36d"

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
