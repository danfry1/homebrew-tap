# danfry1/homebrew-tap

Homebrew formulae for [danfry1](https://github.com/danfry1)'s command-line tools.

| Formula | Description |
| --- | --- |
| [`waxon`](https://github.com/danfry1/waxon) | Vim-modal Spotify terminal client |
| [`hacker-news-tui`](https://github.com/danfry1/hacker-news-tui) | Terminal UI for browsing Hacker News |
| [`marina`](https://github.com/danfry1/marina) | Developer-process cockpit TUI and CLI for local dev servers |
| [`wordle-tui`](https://github.com/danfry1/wordle-tui) | Terminal word-guessing game |

## Install

Recent Homebrew versions only load formulae from third-party taps you trust:

```sh
brew trust danfry1/tap
brew install danfry1/tap/<formula>
```

## Bottles

Every formula builds from its tagged source. Prebuilt bottles, built and tested
in this repository's CI, are published for:

- Apple Silicon Macs on macOS 15 or later
- x86_64 Linux
- ARM Linux

Other platforms, including Intel Macs, build from source. Homebrew installs Go
or Rust for the build automatically. Intel Macs cannot be bottled here because
homebrew-core no longer ships Intel macOS bottles for Go or Rust.

To check a bottle was built by this repository's publish workflow:

```sh
gh attestation verify <bottle>.tar.gz --repo danfry1/homebrew-tap
```

Each tool's own release assets carry their own attestations
(`gh attestation verify <file> --repo danfry1/<tool>`).

## Maintainers

Formula updates come from each tool's release workflow, which opens a pull
request here (branch `<formula>-<version>`). `brew test-bot`
(`.github/workflows/tests.yml`) builds, tests and bottles the changed formula
on that pull request.

Publish a pull request once its checks pass, using the command the bot posts on it:

```sh
gh workflow run publish.yml -R danfry1/homebrew-tap -f pull_request=<N> -f head_sha=<sha>
```

`brew pr-pull` (`.github/workflows/publish.yml`) uploads the bottles to a
release in this repository, attests them, commits the bottle block and closes
the pull request.

- Never merge a formula pull request with the merge button: the formula would
  ship without bottles.
- `tap_migrations.json` moves installs of the old `waxon` cask to the formula.
  Never add `Casks/waxon.rb` back while that entry exists.
