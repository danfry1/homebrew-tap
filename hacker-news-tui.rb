# typed: false
# frozen_string_literal: true

class HackerNewsTui < Formula
  desc "Delightful terminal UI for browsing Hacker News, built with ratatui"
  homepage "https://github.com/danfry1/hacker-news-tui"
  version "0.1.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.2/hacker-news-tui-aarch64-apple-darwin.tar.gz"
      sha256 "a561dcee77ad355d0bba52903440cd0303d052bd7e97f2d75ae8306a568f118d"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.2/hacker-news-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "870a0deeddee515d2b4734f1b9ee242692ac1f80eb8fe2cf84421447da251918"

      def install
        bin.install "hacker-news-tui"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.2/hacker-news-tui-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8ee7b599fec94dca890ec571e80468a9be1042c414b2389e29d62941c1f058b4"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  test do
    assert_match "hacker-news-tui #{version}", shell_output("#{bin}/hacker-news-tui --version")
  end
end
