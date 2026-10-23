# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/danfry1/marina/releases/download/v0.6.0/marina-aarch64-apple-darwin.tar.gz"
      sha256 "6104f764ac6f2708579ede66fcdf4f1ceb3fcb2afae6919bfabbb57af1bb4482"
    end
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.6.0/marina-x86_64-apple-darwin.tar.gz"
      sha256 "af766683e2caa7a7d1beb86b449f65c09e466072c6bd81ee7fbe686c752f8047"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.6.0/marina-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0d0064d897865e58cdb08dc9223d4216f6a1d2048f1a515fd2a63704c94c3dde"
    end
  end

  def install
    bin.install "marina"
  end

  test do
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")
  end
end
