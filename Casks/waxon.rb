# Deprecated: waxon is now a formula built from source (waxon.rb at the tap root),
# so no unsigned binary is installed and macOS quarantine no longer needs to be
# stripped. GoReleaser no longer regenerates this cask; it stays at the last
# version so existing installs see the migration message.
cask "waxon" do
  version "1.10.0"

  on_macos do
    on_arm do
      sha256 "7636474d4cb35df15d564a73938ca8dc110a575eb0f89582128717245f24dc75"
      url "https://github.com/danfry1/waxon/releases/download/v#{version}/waxon_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "2c1271ebc68fc7a80f2838a7dac0474f1007c9f16328bf9105536ac2af8bda88"
      url "https://github.com/danfry1/waxon/releases/download/v#{version}/waxon_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "01b493816e66511106057fe79c7e6ba86506bcf26335fbeb756c93d40addae24"
      url "https://github.com/danfry1/waxon/releases/download/v#{version}/waxon_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "9aa12e7d73899ef64f41d104615168d7c264560017b8bd7023ea0914cabf5ede"
      url "https://github.com/danfry1/waxon/releases/download/v#{version}/waxon_#{version}_linux_amd64.tar.gz"
    end
  end

  name "waxon"
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"

  livecheck do
    skip "Deprecated in favour of the danfry1/tap/waxon formula"
  end

  deprecate! date: "2026-10-24", because: :fails_gatekeeper_check, replacement_formula: "danfry1/tap/waxon"

  binary "waxon"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/waxon"]
    end
  end
end
