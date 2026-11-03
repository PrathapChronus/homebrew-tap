class ClaudeTower < Formula
  desc "Menu bar app showing every Claude Code session on this Mac (session-tower plugin)"
  homepage "https://github.com/ChronusCorp/chronus-ai-stack/tree/main/plugins/session-tower"
  # Private source: fetched over HTTPS with the login from `gh auth setup-git`.
  url "https://github.com/ChronusCorp/chronus-ai-stack.git",
      using:    :git,
      revision: "ab53e93859db30893e9a75117f0f139fd133cd45"
  version "1.0.0"
  license "MIT"

  depends_on macos: :sonoma

  def install
    cd "plugins/session-tower/menubar" do
      system "./build.sh"
      prefix.install "dist/Claude Tower.app"
      bin.install "install-app.sh" => "claude-tower-install"
    end
  end

  def caveats
    <<~EOS
      Copy the app to ~/Applications and start it:
        claude-tower-install            (add --login to start it at login)
      Or run /session-tower:setup in Claude Code, which does this for you.
    EOS
  end

  test do
    assert_predicate prefix/"Claude Tower.app/Contents/MacOS/ClaudeTower", :exist?
  end
end
