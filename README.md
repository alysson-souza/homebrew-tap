# Homebrew Tap

Personal Homebrew tap with various formulas and casks.

## Available packages

### Czkawka

Formulas and a Krokiet cask from the
[Czkawka project](https://github.com/qarmin/czkawka).

Install the Krokiet app:

```fish
brew tap alysson-souza/tap
brew install --cask alysson-souza/tap/krokiet
```

Build the CLI or GTK GUI from source:

```fish
brew install --HEAD alysson-souza/tap/czkawka-cli
brew install --HEAD alysson-souza/tap/czkawka-gui
```

### mpv

Builds mpv from upstream HEAD, including `mpv.app`. Requires macOS and Xcode.

```fish
brew install --HEAD alysson-souza/tap/mpv
ln -s (brew --prefix alysson-souza/tap/mpv)/mpv.app /Applications/mpv.app
```

## Updating

```fish
brew upgrade --cask alysson-souza/tap/krokiet
brew upgrade --fetch-HEAD alysson-souza/tap/mpv
```

Use `--fetch-HEAD` for the Czkawka source formulas too.

## License

This Homebrew tap is licensed under the [MIT License](LICENSE).
Individual packages retain their upstream licenses.

## Upstream projects

- [Czkawka and Krokiet](https://github.com/qarmin/czkawka)
- [mpv](https://github.com/mpv-player/mpv)
