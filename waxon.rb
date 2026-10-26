# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.14.2.tar.gz"
  sha256 "f435755b01a857734c0bcf6bac0bb3f7184441244251d42130a59ae081e50e00"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.14.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4c9b01525ec90cc3da216ca57243502e29bd1bfbb62154cf7943494bef5021b3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9bc35f555f027d992b3abaa3a1a85b7d56b3e15d8dd7986b0c83c8927a231ce9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a10ab81df91fbfba930de0ee6ac52f6dcef7a1640d74d91db6da4315a3bfc4b9"
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
