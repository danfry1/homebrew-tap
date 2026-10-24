# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit TUI and CLI for local dev servers"
  homepage "https://github.com/danfry1/marina"
  url "https://github.com/danfry1/marina/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "278b0f4667da6034487bfb3b0177073d3ad45a8dbf82ca65e7850bf43db136d5"
  license "Apache-2.0"
  revision 1
  head "https://github.com/danfry1/marina.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/marina-0.6.0_1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cf58cdfa10af76e729d46c8a7bfb98e5023cb1859b250864ea1edb74d6557812"
    sha256 cellar: :any,                 arm64_linux:   "a8029548273e2862f7e2760d698462f9fd90bd33327524008feba7f39ac6ee36"
    sha256 cellar: :any,                 x86_64_linux:  "22acc67a8eafc7dc8428f56551fb76da6e8cdcc52ee1db61cef0319f078584d8"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "developer-process cockpit", shell_output("#{bin}/marina help")

    # `marina port` gives a project a stable port and records it. The project
    # sits below HOME: marina ignores a manifest in HOME itself by design.
    (testpath/"demo").mkpath
    (testpath/"demo/package.json").write '{"name":"demo"}'
    cd testpath/"demo" do
      port = shell_output("#{bin}/marina port").strip
      assert_match(/\A\d+\z/, port)
      assert_equal port, shell_output("#{bin}/marina port").strip
      assert_match ":#{port}", shell_output("#{bin}/marina port --list")
    end
  end
end
