# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.13.0.tar.gz"
  sha256 "386b3bed7cc9f21c75926e7e90d9f6c6e82b06d46638dc5910111c1e14bc5930"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.13.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "77c9ec73abf4b0b5ffd6b27d750944d3e6735a6564b26d3d8c0baf6ad8311c74"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "047f3def6ad67e56bf1219990d847f565bef208d628b6423180c3d7ad14fafb8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4ceb4f8c20d8515a497dbf634dbc4554229e2f84a49248dd0b3151259648db0"
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
