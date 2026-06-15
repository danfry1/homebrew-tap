# typed: false
# frozen_string_literal: true

class HackerNewsTui < Formula
  desc "Delightful terminal UI for browsing Hacker News, built with ratatui"
  homepage "https://github.com/danfry1/hacker-news-tui"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.3/hacker-news-tui-aarch64-apple-darwin.tar.gz"
      sha256 "402d6c23d7c81835c4ff52776b672bec055fc346ba849e3cf4a075a615301883"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.3/hacker-news-tui-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "008ae903eefbbe8e89a524e8305bd29e7212732d202f63d7457cfa3639a55d43"

      def install
        bin.install "hacker-news-tui"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/danfry1/hacker-news-tui/releases/download/v0.1.3/hacker-news-tui-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0e63a8861fd333caea612a016dbc248311d892e50b24d77a71255fe7fa458cef"

      def install
        bin.install "hacker-news-tui"
      end
    end
  end

  test do
    assert_match "hacker-news-tui #{version}", shell_output("#{bin}/hacker-news-tui --version")
  end
end
