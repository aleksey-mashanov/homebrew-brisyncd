class Brisyncd < Formula
  desc "Synchronize the brightness of an external display with a main (integrated) display"
  homepage "https://github.com/aleksey-mashanov/brisyncd"
  url "https://github.com/aleksey-mashanov/brisyncd/archive/v1.0.0.tar.gz"
  sha256 "1c8205ea36acace9b9b8ada18a198b2e758bb510244ce3e0ecd09db92c962859"

  depends_on :xcode => :build

  def install
    system "swift", "build", "-c", "release"
    path = `swift build -c release --show-bin-path`.chomp
    sbin.install "#{path}/brisyncd"
  end

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
