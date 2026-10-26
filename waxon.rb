# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.14.1.tar.gz"
  sha256 "98ae83eac806cc5d650c65c10a850eef2ee6c0a779897e4f2e76b316181f66ae"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.14.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "add06b7c9157b58aedb1f61319483151dc37ea0448d282b6fe0de1fa8f237d0c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9dade619423dd51e4eedfaab2bb188accd460860ec859b2722b3906ab923285a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "79ddc41cef27c444190f215c33025ae7e36582a45cc312e70627c6502f9e3d83"
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
