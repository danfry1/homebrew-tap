# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/danfry1/marina/releases/download/v0.1.0/marina-aarch64-apple-darwin.tar.gz"
      sha256 "990feabcf96c5c7c1c021dc6442e8e601ea790bf2ca157f0b4f8e15738b7256d"
    end
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.1.0/marina-x86_64-apple-darwin.tar.gz"
      sha256 "220f81fb108fbfcf5f9b118abfb2ff06776e496383b48992030647280956a4e1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.1.0/marina-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fc67ec858a37e84139917cd4780d254ac176dec81a2906ed3addde57c16d7b15"
    end
  end

  def install
    bin.install "marina"
  end

  test do
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")
  end
end
