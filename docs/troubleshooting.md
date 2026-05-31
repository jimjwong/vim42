# vim42 Troubleshooting

## Header shows marvin@42.fr

This means `vim42` cannot find your configured email.

Check the installed config:

```bash
cat ~/.vimrc_42 | grep -E "user42|mail42|USER|MAIL"
```

Correct example:

```vim
let g:user42 = 'marvin'
let g:mail42 = 'marvin@student.42.fr'
let $USER = 'marvin'
let $MAIL = 'marvin@student.42.fr'
```

## Check what Vim sees

```bash
vim42 test_header.c
```

Inside Vim:

```vim
:Vim42Info
```

## Make sure the alias is correct

```bash
alias vim42
```

Correct:

```bash
vim42='vim -Nu ~/.vimrc_42 --noplugin'
```

The `--noplugin` part prevents normal Vim plugins from interfering.

## Reinstall

From the repo folder:

```bash
./scripts/install.sh your42login your42login@student.42.fr
source ~/.zshrc
```

## Test on a fresh file

```bash
rm -f test_header.c
vim42 test_header.c
```

Inside Vim:

```vim
:Stdheader
```
