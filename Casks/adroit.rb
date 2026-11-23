cask "adroit" do
  version "0.5.2"
  sha256 "269e1aca3ba1015c08449d5f2fb280f000fac3048bddeb494bf027cf86a70379"

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
