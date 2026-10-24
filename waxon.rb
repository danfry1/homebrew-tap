# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "75ac5dcf0783e274d69fe679e9d090d6e417d92231a7217fd28aa4ac3b853d47"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.11.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b4c998a3894e510fc4902ad274d73a45b7bacb35deb7bfb38a6a1ec3b3483c7d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "78e2d163dd4ce100e2125cad9d6982b02feeb2c3ab997a3170bf4eba39729e0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fb603854f7a743379623aeaeed25d74b05a6bf0b1f359ca77b5fabd1b6fce365"
  end

  depends_on "go" => :build

  def install
    # Match the release binaries, which are built without cgo on every platform.
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/waxon version")
    assert_match %r{waxon/config\.json$}, shell_output("#{bin}/waxon config").strip
    assert_match "dracula", shell_output("#{bin}/waxon themes")
    # Without a Spotify login, playback commands fail with a pointer to `waxon auth`.
    assert_match "waxon auth", shell_output("#{bin}/waxon status 2>&1", 1)
  end
end
