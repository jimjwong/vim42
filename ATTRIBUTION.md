# Attribution

The 42 header functionality in this repository comes from the original 42Paris `42header` project.

Original project:

```text
https://github.com/42Paris/42header
```

Original repository owner:

```text
42Paris
```

Original plugin:

```text
stdheader.vim
```

Full credit for the 42 header plugin, header format, and core header behaviour goes to the original `42Paris/42header` project.

This `vim42` repository does not claim ownership of the original 42 header plugin idea. The purpose of this repository is to provide an easier isolated setup around it:

- `stdheader.vim` is installed into `~/.vim42/plugin/`, not `~/.vim/plugin/`.
- 42 identity is configured in `~/.vimrc_42`, not globally in `~/.zshrc`.
- The `vim42` alias launches Vim with the 42-only config.
- Normal Vim remains clean.

In short:

```text
42Paris/42header provides the 42 header plugin.
vim42 provides the isolated Vim setup around it.
```
