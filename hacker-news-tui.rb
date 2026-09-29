# typed: false
# frozen_string_literal: true

class HackerNewsTui < Formula
  desc "Delightful terminal UI for browsing Hacker News, built with ratatui"
  homepage "https://github.com/danfry1/hacker-news-tui"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.2.0/hacker-news-tui-aarch64-apple-darwin.tar.gz"
      sha256 "11a8977987a34ba0cc72f1e63ab95c743a85700c57642ae573eb8525a85d1733"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.2.0/hacker-news-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d9c988b39ce0e4391e39055264cd1e2bd6737e7a38286058e9a15e57942e1f57"

      def install
        bin.install "hacker-news-tui"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.2.0/hacker-news-tui-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1322f987e393479124aa9adb725616ff9c86b93db57e20ff03acc7a16ccdda92"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  test do
    assert_match "hacker-news-tui #{version}", shell_output("#{bin}/hacker-news-tui --version")
  end
end
