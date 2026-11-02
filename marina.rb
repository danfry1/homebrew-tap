# frozen_string_literal: true

class Marina < Formula
  desc "Developer-process cockpit for local dev servers and coding agents"
  homepage "https://github.com/danfry1/marina"
  url "https://github.com/danfry1/marina/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "8678a74c240a7dd0344c92ddd76ca2b38073206fc5140e528dcb80ebb7b2d30b"
  license "Apache-2.0"
  head "https://github.com/danfry1/marina.git", branch: "main"

  # Only stable GitHub releases count, never pre-release tags.
  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/danfry1/homebrew-tap/releases/download/marina-0.10.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6ecca2fb4448b922d19768f924ca5f56fd51b3a7531dbea128338ecfae716d31"
    sha256 cellar: :any,                 arm64_linux:   "ece082b11179ae432748963f6886ee37453a262562e6807640d2091448c28dee"
    sha256 cellar: :any,                 x86_64_linux:  "d132c34c97a90f3103ecee021b03356ff929f4316a490dff9e2fcdc10fba4a09"
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
