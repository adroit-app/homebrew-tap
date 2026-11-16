cask "adroit" do
  version "0.3.0"
  sha256 "7f7315fc96c176d556156b4047dd44a87bc41e1ad8de46aee27b5338b584e759"

  url "https://github.com/adroit-app/Adroit/releases/download/v#{version}/Adroit_#{version}_aarch64.dmg"
  name "Adroit"
  desc "Agent Workspace for people who live in Vim"
  homepage "https://github.com/adroit-app/Adroit"

  depends_on arch: :arm64

  app "Adroit.app"
  binary "#{appdir}/Adroit.app/Contents/MacOS/adroit"

  # Adroit is signed by a self-signed certificate, not by an Apple Developer
  # ID, nor notarized, so Gatekeeper refuses the quarantined bundle
  # ("damaged") and Homebrew no longer offers --no-quarantine. Recursive, as
  # the Neovim the app carries is quarantined too.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Adroit.app"]
  end
end
