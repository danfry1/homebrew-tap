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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "142a18f661ecf428150031c515411f334bc3842985733c9d9d20995741db2084"
    sha256 cellar: :any,                 arm64_linux:   "64a1ebe4b6b1c8288b8cb36552f663f5ec19830eddb7b3f5e3743fc13c80d6d8"
    sha256 cellar: :any,                 x86_64_linux:  "5080daef1a067e4f429bd5b27d04cfb286671fe980413bd36cfeb1e630a4eeb2"
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
