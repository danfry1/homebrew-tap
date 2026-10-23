# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/danfry1/marina/releases/download/v0.4.0/marina-aarch64-apple-darwin.tar.gz"
      sha256 "6ed039a986555ad5eebcbde13570f2ef41d658f2cd58629d59539b7350ef7e62"
    end
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.4.0/marina-x86_64-apple-darwin.tar.gz"
      sha256 "b531328d872bc50c7a682f99b0fc936d4249a5f63f6beaff3c1a5fc0aec0f6da"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/danfry1/marina/releases/download/v0.4.0/marina-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "700e016df05c15dd5379afd4169c95c9e2519781c9a2ad652a76acfb97a249df"
    end
  end

  def install
    bin.install "marina"
  end

  test do
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")
  end
end
