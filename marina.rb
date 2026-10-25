# frozen_string_literal: true

class Marina < Formula
  desc "Inbox for coding-agent sessions and the dev servers they start"
  homepage "https://github.com/danfry1/marina"
  url "https://github.com/danfry1/marina/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "27c8c6d8371416f00a7c87209ad150c456f1364353dd24b56a17698e13ddfe9c"
  license "Apache-2.0"
  revision 1
  head "https://github.com/danfry1/marina.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/marina-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f172c75a6b154c44563583bf4d7a609a8b62d328a3a072c099316c321e98b07"
    sha256 cellar: :any,                 arm64_linux:   "68007a6531f672b38cb10120842e4ccee2ed21823dd5a93b6e8ea159d3a945ea"
    sha256 cellar: :any,                 x86_64_linux:  "d944e2d8f8c350e7581a7203f97e1b0e47f8a2ccb729a56ef8cdbc199557a77d"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "deliberately wrong (CI check test)", shell_output("#{bin}/marina help")

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
