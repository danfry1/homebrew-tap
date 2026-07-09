# typed: false
# frozen_string_literal: true

class HackerNewsTui < Formula
  desc "Delightful terminal UI for browsing Hacker News, built with ratatui"
  homepage "https://github.com/danfry1/hacker-news-tui"
  version "0.1.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.4/hacker-news-tui-aarch64-apple-darwin.tar.gz"
      sha256 "76d8faf93f9951e1c36af1a8c2090b26fa5af9b4510ac94f91146a912c2fad64"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.4/hacker-news-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1985c8aa417c4457c5ecaca16deded2dff67d3507a250ba3a8df31e8131d5ecc"

      def install
        bin.install "hacker-news-tui"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.4/hacker-news-tui-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d11d17d064eea3de975e7a3f5840452c35f66d75b0df9d5d99ae2ff3ac1b12d0"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  test do
    assert_match "hacker-news-tui #{version}", shell_output("#{bin}/hacker-news-tui --version")
  end
end
