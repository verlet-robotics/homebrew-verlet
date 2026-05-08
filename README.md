# homebrew-verlet

Homebrew tap for the [Verlet CLI](https://github.com/verlet-robotics/verlet-cli).

## Install

```sh
brew install verlet-robotics/verlet/verlet
```

Or, equivalently:

```sh
brew tap verlet-robotics/verlet
brew install verlet
```

Verify:

```sh
verlet --version
```

## Updating

```sh
brew update
brew upgrade verlet
```

New formula versions are auto-PR'd on every `verlet-cli` PyPI release by
[`dawidd6/action-homebrew-bump-formula`](https://github.com/dawidd6/action-homebrew-bump-formula),
gated by the `brew test-bot` workflow in this repo.
