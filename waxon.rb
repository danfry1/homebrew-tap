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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "35da9b4f53181459021047c1b157a920a29d16f04cb572bfa048c75afd13a56a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "84523795b150ac9012dcea40d64eb7e4d06e030cf9f4a8f0a570ab63aad5281a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a7c96ef1db58ebde3244a60096bec7df62fc1cb61fee6dfdf2ac7ee71e855c53"
  end

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
