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

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/hacker-news-tui-0.2.0"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6836158ca5d770c277028d1a3a0a38f7747323acadae457af406b3221eca27bd"
    sha256 cellar: :any,                 arm64_linux:   "f8bc02b6ef2a683a9b9f33a45c4b94f51f6bde5cb88f26db5ef40d5cc9747ee6"
    sha256 cellar: :any,                 x86_64_linux:  "f9d74cbde2ee4b5d1ae43f445b20b7360bd8116f7d9e89dbcdc60cf44a05259d"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hacker-news-tui --version")

    # Start the TUI in a pseudo-terminal and check it draws its feed tabs and quits cleanly.
    require "pty"
    require "io/console"
    ENV["TERM"] = "xterm-256color"
    output = +""
    PTY.spawn("#{bin}/hacker-news-tui") do |r, w, pid|
      r.winsize = [30, 100]
      sleep 3
      w.write "q"
      begin
        r.each_char { |c| output << c }
      rescue Errno::EIO
        # Linux raises EIO once the program closes the terminal.
      end
      _, status = Process.wait2(pid)
      assert_equal 0, status.exitstatus
    end
    screen = output.gsub(%r{\e\[[0-9;?]*[ -/]*[@-~]}, "")
    assert_match "Hacker News", screen
    assert_match "Top", screen
    assert_match "Ask", screen
  end
end
