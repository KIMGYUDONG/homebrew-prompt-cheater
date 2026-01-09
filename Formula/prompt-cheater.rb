class PromptCheater < Formula
  include Language::Python::Virtualenv

  desc "Convert natural language to Claude-friendly XML prompts and inject into Tmux"
  homepage "https://github.com/KIMGYUDONG/prompt-cheater"
  url "https://files.pythonhosted.org/packages/41/43/dc155a536d4502801794f2c5f3d03f53bbb6246e4047df61e0d542360d78/prompt_cheater-0.1.0.tar.gz"
  sha256 "b276b3fde9b729dd177ffbaaac980b198b960b124afc30549eef21d3e2a4b209"
  license "MIT"

  depends_on "python@3.12"
  depends_on "tmux"

  def install
    virtualenv_create(libexec, "python3.12")
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
           "--ignore-installed", buildpath
    bin.install_symlink Dir[libexec/"bin/cheater"]
  end

  def caveats
    <<~EOS
      To use prompt-cheater, you need to set your Gemini API key:
        export GEMINI_API_KEY="your_api_key_here"

      Get your API key from: https://aistudio.google.com/apikey
    EOS
  end

  test do
    assert_match "Prompt Cheater", shell_output("#{bin}/cheater --version")
  end
end
