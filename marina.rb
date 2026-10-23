# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/danfry1/marina/releases/download/v0.5.0/marina-aarch64-apple-darwin.tar.gz"
      sha256 "30c44bf1458d8156585c8531dbe75b93b00dddc3fb52aad772a2289a75531aee"
    end
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.5.0/marina-x86_64-apple-darwin.tar.gz"
      sha256 "238dbc3497d18fd572c34fb7a2cfa6b665d20c3ab8c980cefb514144d41070d5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.5.0/marina-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8d07820861e33d0f9d90a1b982acf34508359b671a360b1b94cb0fd39dc3c13b"
    end
  end

  def install
    bin.install "marina"
  end

  test do
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")
  end
end
