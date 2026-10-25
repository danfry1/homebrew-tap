# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.12.0.tar.gz"
  sha256 "7feb1299e54001c3411170232ee1dee316d1f17cf7400de95aad03bd098e4fd9"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/waxon-1.12.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "770cf1c46aba3a00e1784bbcdc600c710fa9ad128b0b4fe472ec17f74048f385"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9e47f49d12b0fe01d3ea91bab8e5580a197ad4a376a5866dcfe0da8d034a211c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c9d6a09caed68c2e372babe47e2cd87830d0bc4aad42385766cd41250887e4f"
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
