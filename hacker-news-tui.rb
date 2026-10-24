# frozen_string_literal: true

class HackerNewsTui < Formula
  desc "Delightful terminal UI for browsing Hacker News, built with ratatui"
  homepage "https://github.com/danfry1/hacker-news-tui"
  url "https://github.com/danfry1/hacker-news-tui/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "eec1815c89d02462b125e0d7b9d0bbc6dbd92d59f6ed95a0b1c1de914ed4eeaf"
  license "MIT"
  head "https://github.com/danfry1/hacker-news-tui.git", branch: "main"

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
    assert_match "hacker-news-tui #{version}", shell_output("#{bin}/hacker-news-tui --version")
  end
end
