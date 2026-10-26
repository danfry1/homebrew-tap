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
