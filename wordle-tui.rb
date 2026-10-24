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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "26fd7c323debc2d632a544e00bfdce639fa02447e50bc3fa6a002407e4f7e37f"
    sha256 cellar: :any,                 arm64_linux:   "1d635a773f35812ee4ea818a83aed431a64d1aea9bb159755f460b200951c299"
    sha256 cellar: :any,                 x86_64_linux:  "1290fb9d0a0d3c3090aa5f12fe694f6246e395d1bef2e2f93887d0a2dfe6f0d6"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/wordle-tui --version")

    # Start the TUI in a pseudo-terminal and check it draws the board and quits cleanly.
    require "pty"
    require "io/console"
    ENV["TERM"] = "xterm-256color"
    output = +""
    PTY.spawn("#{bin}/wordle-tui") do |r, w, pid|
      r.winsize = [30, 100]
      sleep 3
      w.write "\e"
      begin
        r.each_char { |c| output << c }
      rescue Errno::EIO
        # Linux raises EIO once the program closes the terminal.
      end
      _, status = Process.wait2(pid)
      assert_equal 0, status.exitstatus
    end
    screen = output.gsub(%r{\e\[[0-9;?]*[ -/]*[@-~]}, "")
    assert_match "WORDLE", screen
  end
end
