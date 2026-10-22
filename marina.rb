# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/danfry1/marina/releases/download/v0.3.0/marina-aarch64-apple-darwin.tar.gz"
      sha256 "05ff2a6322a1381650fefc706da620c139d377c2d0bbf955c0c24e0db5968e1d"
    end
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.3.0/marina-x86_64-apple-darwin.tar.gz"
      sha256 "15aa13cf2448ade46d25515cbb0ee1812a77da3dd8ee38e81a82e0814a7af938"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.3.0/marina-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "11c6c3e33fcacc8c014ab7a600a7655c222e75e44d067b95b2bd5d755e8b1860"
    end
  end

  def install
    bin.install "marina"
  end

  test do
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")
  end
end
