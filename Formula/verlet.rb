# typed: true
# frozen_string_literal: true

# Verlet CLI — download and explore Verlet datasets from the command-line.
class Verlet < Formula
  include Language::Python::Virtualenv

  desc "Download and explore Verlet datasets from the command-line"
  homepage "https://github.com/verlet-robotics/verlet-cli"
  url "https://files.pythonhosted.org/packages/6d/00/34fc4fd82250e5d41500a7b8199aa2a674dde7a9d13c3bd592ace0dda840/verlet-0.8.1.tar.gz"
  sha256 "e855a1f56a2a45a677b4dee6eb1faaa51572fe85c01a429ab288a2bac84b1c3a"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :pypi
  end

  # hf_xet is the Hugging Face Xet client — a Rust extension that
  # huggingface_hub 1.x marks as a hard runtime dep on supported
  # architectures. Building it from sdist requires cargo + cc-rs to
  # compile aws-lc-sys's bundled C, but Homebrew's superenv strips the
  # `-I` include paths cc-rs hands clang (the registry tree under
  # CARGO_HOME isn't on superenv's allowlist), so the compile fails
  # silently with `pip` reporting "No available output". Earlier
  # workarounds in this tap — adding rust+maturin (#1) and inreplacing
  # xet_client's Cargo.toml to swap rustls-tls for native-tls (#2) —
  # were unreliable across macOS Tahoe arm64 and added an unverified
  # tampering step against vendored Cargo manifests that would need
  # re-validating on every hf_xet bump. Ship the prebuilt cp37-abi3
  # wheels instead — see the per-platform `resource "hf-xet"` block
  # below. With wheels in play we no longer need rust, maturin, or
  # pkgconf during `brew install`.

  depends_on "libyaml"
  depends_on "python@3.12"

  resource "annotated-doc" do
    url "https://files.pythonhosted.org/packages/57/ba/046ceea27344560984e26a590f90bc7f4a75b06701f653222458922b558c/annotated_doc-0.0.4.tar.gz"
    sha256 "fbcda96e87e9c92ad167c2e53839e57503ecfda18804ea28102353485033faa4"
  end

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/19/14/2c5dd9f512b66549ae92767a9c7b330ae88e1932ca57876909410251fe13/anyio-4.13.0.tar.gz"
    sha256 "334b70e641fd2221c1505b3890c69882fe4a2df910cba14d97019b90b24439dc"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/25/ee/6caf7a40c36a1220410afe15a1cc64993a1f864871f698c0f93acb72842a/certifi-2026.4.22.tar.gz"
    sha256 "8d455352a37b71bf76a79caa83a3d6c25afee4a385d632127b6afb3963f1c580"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/bb/63/f9e1ea081ce35720d8b92acde70daaedace594dc93b693c869e0d5910718/click-8.3.3.tar.gz"
    sha256 "398329ad4837b2ff7cbe1dd166a4c0f8900c3ca3a218de04466f38f6497f18a2"
  end

  resource "filelock" do
    url "https://files.pythonhosted.org/packages/b5/fe/997687a931ab51049acce6fa1f23e8f01216374ea81374ddee763c493db5/filelock-3.29.0.tar.gz"
    sha256 "69974355e960702e789734cb4871f884ea6fe50bd8404051a3530bc07809cf90"
  end

  resource "fsspec" do
    url "https://files.pythonhosted.org/packages/d5/8d/1c51c094345df128ca4a990d633fe1a0ff28726c9e6b3c41ba65087bba1d/fsspec-2026.4.0.tar.gz"
    sha256 "301d8ac70ae90ef3ad05dcf94d6c3754a097f9b5fe4667d2787aa359ec7df7e4"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end

  # Platform-specific abi3 wheels for hf_xet 1.5.0. cp37-abi3 means a
  # single wheel covers cpython 3.7 through 3.x, so this stays valid as
  # long as we're on python@3.12 (or any future bump that's >= 3.7).
  resource "hf-xet" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/9b/ff/edcc2b40162bef3ff78e14ab637e5f3b89243d6aee72f5949d3bb6a5af83/hf_xet-1.5.0-cp37-abi3-macosx_11_0_arm64.whl"
        sha256 "fd6e5a9b0fdac4ed03ed45ef79254a655b1aaab514a02202617fbf643f5fdf7a"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/3d/fb/69ff198a82cae7eb1a69fb84d93b3a3e4816564d76817fe541ddc96874eb/hf_xet-1.5.0-cp37-abi3-macosx_10_12_x86_64.whl"
        sha256 "dad0dc84e941b8ba3c860659fe1fdc35c049d47cce293f003287757e971a8f56"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/c4/a2/546f47f464737b3edbab6f8ddb57f2599b93d2cbb66f06abb475ccb48651/hf_xet-1.5.0-cp37-abi3-manylinux_2_28_aarch64.whl"
        sha256 "9a0ee58cd18d5ea799f7ed11290bbccbe56bdd8b1d97ca74b9cc49a3945d7a3b"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/49/4d/103f76b04310e5e57656696cc184690d20c466af0bca3ca88f8c8ea5d4f3/hf_xet-1.5.0-cp37-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "3531b1823a0e6d77d80f9ed15ca0e00f0d115094f8ac033d5cae88f4564cc949"
      end
    end
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end

  resource "huggingface-hub" do
    url "https://files.pythonhosted.org/packages/39/40/43109e943fd718b0ccd0cd61eb4f1c347df22bf81f5874c6f22adf44bcff/huggingface_hub-1.14.0.tar.gz"
    sha256 "d6d2c9cd6be1d02ae9ec6672d5587d10a427f377db688e82528f426a041622c2"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/ce/cc/762dfb036166873f0059f3b7de4565e1b5bc3d6f28a414c13da27e442f99/idna-3.13.tar.gz"
    sha256 "585ea8fe5d69b9181ec1afba340451fba6ba764af97026f92a91d4eef164a242"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/d7/f1/e7a6dd94a8d4a5626c03e4e99c87f241ba9e350cd9e6d75123f992427270/packaging-26.2.tar.gz"
    sha256 "ff452ff5a3e828ce110190feff1178bb1f2ea2281fa2075aadb987c2fb221661"
  end

  resource "pygments" do
    url "https://files.pythonhosted.org/packages/c3/b2/bc9c9196916376152d655522fdcebac55e66de6603a76a02bca1b6414f6c/pygments-2.20.0.tar.gz"
    sha256 "6757cd03768053ff99f3039c1a36d6c0aa0b263438fcab17520b30a303a82b5f"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "shellingham" do
    url "https://files.pythonhosted.org/packages/58/15/8b3609fd3830ef7b27b655beb4b4e9c62313a4e8da8c676e142cc210d58e/shellingham-1.5.4.tar.gz"
    sha256 "8dbca0739d487e5bd35ab3ca4b36e11c4078f3a234bfce294b0a0291363404de"
  end

  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/09/a9/6ba95a270c6f1fbcd8dac228323f2777d886cb206987444e4bce66338dd4/tqdm-4.67.3.tar.gz"
    sha256 "7d825f03f89244ef73f1d4ce193cb1774a8179fd96f31d7e1dcde62092b960bb"
  end

  resource "typer" do
    url "https://files.pythonhosted.org/packages/e4/51/9aed62104cea109b820bbd6c14245af756112017d309da813ef107d42e7e/typer-0.25.1.tar.gz"
    sha256 "9616eb8853a09ffeabab1698952f33c6f29ffdbceb4eaeecf571880e8d7664cc"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  def install
    # virtualenv_install_with_resources unconditionally passes
    # --no-binary=:all: to pip and stages each resource into a temp
    # directory. That works for sdists but breaks for the hf-xet wheel —
    # pip can't reinstall an already-unpacked .whl from a source dir, so
    # the install dies with "Neither 'setup.py' nor 'pyproject.toml'
    # found". Build the venv ourselves, install everything except hf-xet
    # via the normal source path, then pip-install hf-xet directly from
    # the cached .whl that Homebrew already downloaded for us.
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install resources.reject { |r| r.name == "hf-xet" }

    # Homebrew's download cache prefixes the filename with the sha256 of
    # the resource (`<hash>--hf_xet-1.5.0-cp37-abi3-…whl`). pip's PEP 427
    # parser rejects that — "Invalid wheel filename (wrong number of
    # parts)" — so copy the wheel into buildpath under its canonical name
    # before handing it to pip.
    # Derive the canonical wheel filename from the resource URL rather
    # than from the cached_download path. Homebrew currently stores
    # downloads as `<sha256>--<basename>`, but that format is internal
    # and has changed before; deriving from the URL keeps us pinned to a
    # public contract (PyPI's filename) instead of Homebrew's cache layout.
    hf_xet_res = resource("hf-xet")
    hf_xet_whl = buildpath/File.basename(URI(hf_xet_res.url).path)
    cp hf_xet_res.cached_download, hf_xet_whl
    # The venv is created with `--without-pip`, so `<venv>/bin/pip`
    # doesn't exist. Invoke pip the same way Homebrew does internally:
    # via the system python3.12 with `-m pip --python=<venv-python>`.
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "pip",
           "--python=#{venv.root}/bin/python",
           "install", "--no-deps", "--ignore-installed", hf_xet_whl.to_s

    venv.pip_install_and_link buildpath
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/verlet --version")
  end
end
