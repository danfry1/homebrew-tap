# frozen_string_literal: true

class HackerNewsTui < Formula
  desc "Delightful terminal UI for browsing Hacker News, built with ratatui"
  homepage "https://github.com/danfry1/hacker-news-tui"
  url "https://github.com/danfry1/hacker-news-tui/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "ab7b991debb510aa2b9c405d83e42063587e2c5fc21a371143468629d408350c"
  license "MIT"
  head "https://github.com/danfry1/hacker-news-tui.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/hacker-news-tui-0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "695ccce652f2b5883f8c638c4608bb518aa5401bea19e21b140eea8ee1b1143e"
    sha256 cellar: :any,                 arm64_linux:   "032a80cd8994c318bb1badd7b033904279f503ccc79176f41c0c5bce6b3fd32b"
    sha256 cellar: :any,                 x86_64_linux:  "ae08e7dab0d7095284729f3fd56e174ff0d5a2e2407da0437b9d4f806390c1c7"
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
