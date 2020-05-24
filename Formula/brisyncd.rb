class Brisyncd < Formula
  desc "Synchronize brightness of external display with main display"
  homepage "https://github.com/aleksey-mashanov/brisyncd"
  url "https://github.com/aleksey-mashanov/brisyncd/archive/v1.1.0.tar.gz"
  sha256 "d163f2e37627e61c14dbbea503e18b7e14c5848254f8ec0b40bdbd027f32def0"
  head "https://github.com/aleksey-mashanov/brisyncd.git"

  bottle do
    root_url "https://dl.bintray.com/aleksey-mashanov/bottles-brisyncd"
    cellar :any_skip_relocation
    sha256 "0c9477a47a45588ab4590a328e6a1a8a2cc46a2860d6a4b566b591d67187b2e6" => :catalina
  end

  depends_on :xcode => :build

  def install
    system "swift", "build", "-c", "release"
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
