# rajpdus/homebrew-tap

Homebrew tap for [rajpdus](https://github.com/rajpdus) projects.

```sh
brew tap rajpdus/tap
brew install --cask --no-quarantine androidft
```

| Cask | What it is |
|---|---|
| [`androidft`](Casks/androidft.rb) | [AndroidFT](https://github.com/rajpdus/androidft): native Apple Silicon file transfer app for Android phones (MTP). |

`--no-quarantine` is needed because the app is signed ad hoc, not with an Apple Developer ID.
