cask "cammob" do
  version "0.1.0"
  sha256 "a82a4234a6757a9324648370a1e5e6f3a532b4330c456ed0d8a2c12a6ee912d7"

  url "https://github.com/rajpdus/cammob/releases/download/v#{version}/CamMob-#{version}.zip"
  name "CamMob"
  desc "Native macOS viewer for CP Plus (gCMOB/iCMOB) DVRs over P2P"
  homepage "https://rajpdus.github.io/cammob/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "CamMob.app"

  # The app is signed ad hoc (no Apple Developer ID); without this Gatekeeper
  # refuses to open the downloaded copy.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/CamMob.app"]
  end

  zap trash: [
    "~/Library/Preferences/com.rajpdus.cammob.plist",
    "~/Library/Saved Application State/com.rajpdus.cammob.savedState",
  ]

  caveats <<~EOS
    CamMob stores DVR passwords in your login Keychain. Add a recorder with
    its P2P serial number (scan the QR on the DVR, or import a gCMOB device card).
  EOS
end
