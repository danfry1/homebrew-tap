# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.14.0.tar.gz"
  sha256 "b8f116d89a1e657c0bd8f4b3cc7a5318cd680cad91b115f322cc8f54a744ab1e"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.14.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e65dd14b393cd6041116ae2bfff354331cbb0381525b60dd4512f2283b9acb06"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "359467a6fd946119eda8ce2a49e6a5523405b2075476b9abc6759c2e99a4b6a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6c08153b8dfe09522cfb94b42178a416bbb7c6a9b63f7825d1834eebd2aa5cd"
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
