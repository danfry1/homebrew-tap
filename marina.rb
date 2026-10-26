# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit for local dev servers and coding agents"
  homepage "https://github.com/danfry1/marina"
  url "https://github.com/danfry1/marina/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "7254ef49813b7cf6380077c806c195c0914f39728b2d500949d5de1c7fe748bb"
  license "Apache-2.0"
  head "https://github.com/danfry1/marina.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/marina-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "776159fc58aa12c10721dfe3899a2166e57b791ec8fa82c9dd346bc8dd316620"
    sha256 cellar: :any,                 arm64_linux:   "928e58d2b852b4be3ee681b38e38478ec6fad41005174361a2005c90a05f5bb4"
    sha256 cellar: :any,                 x86_64_linux:  "9329e3631ccacfd3df3abde674e065f2676eaa051efbecd60560d8ddf2f44e64"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    # The version, not the help text: a reworded tagline mustn't fail the bottles.
    assert_equal "marina #{version}", shell_output("#{bin}/marina version").strip

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
