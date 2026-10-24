# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "8ee5efbd88aca8545e9013280e8b8e9337dbb3f412e790cae8bba8fb81cf5080"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.10.0"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "52f99a61bdfe7709446daa16b73334a424bf9348c5963c3e3fcdbe1e21ef8f0b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f491949ebe8b4a4f73b74bf705b41d8a51808931d87ad86e9e9bacaa92c3e985"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "361323763f4ba6677a8790620b3f21c404ee3b08629680840c16e7b10eeb58fe"
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
