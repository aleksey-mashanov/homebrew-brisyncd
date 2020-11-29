class Brisyncd < Formula
  desc "Synchronize brightness of external display with main display"
  homepage "https://github.com/aleksey-mashanov/brisyncd"
  url "https://github.com/aleksey-mashanov/brisyncd/archive/v1.2.0.tar.gz"
  sha256 "fa9aebf69ca7ad0a951c04670d511fe445cfd16266706829e580ac05ac6402b5"
  head "https://github.com/aleksey-mashanov/brisyncd.git"
  license "MIT"

  bottle do
    root_url "https://dl.bintray.com/aleksey-mashanov/bottles-brisyncd"
    cellar :any_skip_relocation
    sha256 "50c8978404f9b36adb9dbd3303b2c371e55d5eff31b69c3b79192668e06eaf0f" => :catalina
  end

  depends_on :xcode => :build

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    path = `swift build -c release --show-bin-path`.chomp
    sbin.install "#{path}/brisyncd"
  end

  plist_options :manual => "brisyncd"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{opt_sbin}/brisyncd</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
      </dict>
      </plist>
    EOS
  end
end
