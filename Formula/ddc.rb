class Ddc < Formula
  desc "Get/set settings of displays compatible with DDC/CI"
  homepage "https://github.com/aleksey-mashanov/swift-ddc"
  url "https://github.com/aleksey-mashanov/swift-ddc/archive/v1.0.0.tar.gz"
  sha256 "291e4c8e2c2c3423eb981c722f7eb4e92c0470e1d4984637ffbd2928fec85f95"
  head "https://github.com/aleksey-mashanov/swift-ddc.git"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/aleksey-mashanov/bottles-brisyncd"
    cellar :any_skip_relocation
    sha256 "3c052f02993fdadaf6ea8545ecd3eee10d15529e6c0e873cb391088234da66f4" => :catalina
  end

  depends_on :xcode => :build

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    path = `swift build -c release --show-bin-path`.chomp
    bin.install "#{path}/ddc"
  end
end
