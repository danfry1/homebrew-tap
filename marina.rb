# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  url "https://github.com/danfry1/marina/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "278b0f4667da6034487bfb3b0177073d3ad45a8dbf82ca65e7850bf43db136d5"
  license "Apache-2.0"
  revision 1
  head "https://github.com/danfry1/marina.git", branch: "main"

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
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")
  end
end
