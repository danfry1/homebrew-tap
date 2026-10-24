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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "687f97d4ca55245384584d62419119b12ea7c8e53864a6f32ab319c50aaf0010"
    sha256 cellar: :any,                 arm64_linux:   "3e5ace5072178b68ed887402a4c31787b08efba5bbcf4b0a0af9f6d3c87e2836"
    sha256 cellar: :any,                 x86_64_linux:  "87f955ed8f585a3ae8731769daa0e6f4c8df92f9abec2790882393b9133e07ff"
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
    screen = output.gsub(/\e\[[0-9;?]*[ -\/]*[@-~]/, "")
    assert_match "Hacker News", screen
    assert_match "Top", screen
    assert_match "Ask", screen
  end
end
