class PromptCheater < Formula
  desc "Convert natural language to Claude-friendly XML prompts and inject into Tmux"
  homepage "https://github.com/KIMGYUDONG/prompt-cheater"
  url "https://files.pythonhosted.org/packages/88/50/78363391d9a0c329b6e9146cfbd7a9fa414c4cfa1adab37030a201fd1b3b/prompt_cheater-0.2.2.tar.gz"
  sha256 "fd266a3aab3dca95317e6b072d5870bd6c536bfcca0acb0ee0d61daeb78e42e0"
  license "MIT"

  depends_on "python@3.12"
  depends_on "tmux"

  def install
    python = Formula["python@3.12"].opt_bin/"python3.12"

    # Create virtual environment with pip
    system python, "-m", "venv", libexec

    # Install prompt-cheater from PyPI
    system libexec/"bin/pip", "install", "--upgrade", "pip"
    system libexec/"bin/pip", "install", "prompt-cheater==0.2.2"

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
