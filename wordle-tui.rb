# frozen_string_literal: true

class WordleTui < Formula
  desc "Beautiful terminal word-guessing game built with ratatui"
  homepage "https://github.com/danfry1/wordle-tui"
  url "https://github.com/danfry1/wordle-tui/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2b3c8988c377e63e46e19ace80f41a875589f11090b3ad4b52fb9ce66b87cadc"
  license "MIT"
  head "https://github.com/danfry1/wordle-tui.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/wordle-tui-0.1.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4fda1cb8a9940e7a8aefb19b0230b57a399db0a3cabbb628b2492973abc14de2"
    sha256 cellar: :any,                 arm64_linux:   "f29f25e97b3cf2c29c0cef70da4bbb6b3410cd3b2f50e8140827597c116ab1b2"
    sha256 cellar: :any,                 x86_64_linux:  "8ddd19753916bcf8b862e5b5c67f2e1c1d8b313c6de00943b4421241b7ab472a"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "wordle-tui #{version}", shell_output("#{bin}/wordle-tui --version")
  end
end
