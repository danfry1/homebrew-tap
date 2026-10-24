# frozen_string_literal: true

class Waxon < Formula
  desc "Vim-modal Spotify terminal client"
  homepage "https://github.com/danfry1/waxon"
  url "https://github.com/danfry1/waxon/archive/refs/tags/v1.10.0.tar.gz"
  sha256 "8ee5efbd88aca8545e9013280e8b8e9337dbb3f412e790cae8bba8fb81cf5080"
  license "GPL-3.0-only"
  head "https://github.com/danfry1/waxon.git", branch: "main"

  depends_on "go" => :build

  def install
    # Match the release binaries, which are built without cgo on every platform.
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", *std_go_args(ldflags: "-X main.version=#{version}")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/waxon --version")
  end
end
