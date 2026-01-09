class PromptCheater < Formula
  desc "Convert natural language to Claude-friendly XML prompts and inject into Tmux"
  homepage "https://github.com/KIMGYUDONG/prompt-cheater"
  url "https://files.pythonhosted.org/packages/d9/1d/a289fd97547de4495d2620433565aef3b00efea5b068d9ce30f624a6fa9d/prompt_cheater-0.2.1.tar.gz"
  sha256 "c4fad108b9a48bbf80dbeb04d9073e257ad94095ec1a7e26d653357312a43953"
  license "MIT"

  depends_on "python@3.12"
  depends_on "tmux"

  def install
    python = Formula["python@3.12"].opt_bin/"python3.12"

    # Create virtual environment with pip
    system python, "-m", "venv", libexec

    # Install prompt-cheater from PyPI
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "prompt-cheater==0.2.1"

    # Create symlink for the cheater command
    bin.install_symlink libexec/"bin/cheater"
  end

  def caveats
    <<~EOS
      To use prompt-cheater, set your Gemini API key:
        cheater config set

      Or use environment variable:
        export GEMINI_API_KEY="your_api_key_here"

      Get your API key from: https://aistudio.google.com/apikey
    EOS
  end

  test do
    assert_match "Prompt Cheater", shell_output("#{bin}/cheater --version")
  end
end
