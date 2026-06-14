# typed: false
# frozen_string_literal: true

class HackerNewsTui < Formula
  desc "Delightful terminal UI for browsing Hacker News, built with ratatui"
  homepage "https://github.com/danfry1/hacker-news-tui"
  version "0.1.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.1/hacker-news-tui-aarch64-apple-darwin.tar.gz"
      sha256 "00100b83b7d5295efc07fd80bf8db9348d58c1e167be8309bb5a86b5d3636be2"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.1/hacker-news-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "890238020d3a44e0592abec3c238fcdf012d0e3089a8434f4341ca87db04fe56"

      def install
        bin.install "hacker-news-tui"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.1/hacker-news-tui-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "917b7fdbb0d0083059e3015f606a0d9ce65037b5c2122c04180c297227dc58bb"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  test do
    assert_match "hacker-news-tui #{version}", shell_output("#{bin}/hacker-news-tui --version")
  end
end
