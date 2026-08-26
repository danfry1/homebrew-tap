# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/danfry1/marina/releases/download/v0.2.0/marina-aarch64-apple-darwin.tar.gz"
      sha256 "ba5917a52c379685346b31f9310df1d67f0cdbf53bccbb1af442d76c917a1bad"
    end
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.2.0/marina-x86_64-apple-darwin.tar.gz"
      sha256 "72d16cc479b110281f178773feacc138f57bd3b4b2ee96ec0ec50689c381ea0f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.2.0/marina-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5f403e5ed842906708dc199d4f8c9b3bdb7647005eecaaacab72f145bbc7a96a"
    end
  end

  def install
    bin.install "marina"
  end

  test do
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")
  end
end
