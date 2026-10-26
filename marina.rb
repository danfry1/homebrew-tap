# frozen_string_literal: true

class Marina < Formula
  desc "Inbox for coding-agent sessions and the dev servers they start"
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

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "one inbox for your coding agents", shell_output("#{bin}/marina help")

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
