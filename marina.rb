# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit for local dev servers and coding agents"
  homepage "https://github.com/danfry1/marina"
  url "https://github.com/danfry1/marina/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "ee4d7a084488faef5237ee4da33621400c3854e5dd54d3093dae2ff6a5f35fc5"
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
