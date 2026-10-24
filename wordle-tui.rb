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

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "wordle-tui #{version}", shell_output("#{bin}/wordle-tui --version")
  end
end
