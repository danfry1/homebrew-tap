# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.14.3.tar.gz"
  sha256 "2fd3a4dd93052c67c356b9693b9cea0b02774c51bd7ef7c820cb247091d49352"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.14.3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "952511bb3797659453e7a91ea71fffbc34e4836b8f1fd2ff194079fbb7ebee3b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "04a3f60e61dd6a653d10d0f40f36568d163198d15a71c747e149b9867baeddf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6edb6456179b3d149a14489b1c63ce39a8d3dbc31c3bff92925ca0a896729ef7"
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
