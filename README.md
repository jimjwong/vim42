# vim42

A clean, isolated Vim setup for 42 School projects.

`vim42` gives you a separate Vim environment for 42 work, including:

- 42 header support
- Norminette-friendly tab settings
- visible tabs and trailing spaces
- local-only 42 username and email configuration
- no pollution of your normal Vim setup

Use normal Vim for normal work:

```bash
vim main.c
```

Use `vim42` for 42 projects:

```bash
vim42 main.c
```

---

## Why vim42?

The usual 42 header setup often asks you to place `stdheader.vim` inside:

```text
~/.vim/plugin/
```

That means the 42 header plugin loads every time you open normal Vim.

`vim42` keeps the 42 setup separate:

```text
~/.vim42/plugin/stdheader.vim
~/.vimrc_42
```

Then it gives you a simple command:

```bash
vim42
```

So your normal Vim stays clean.

---

## Final setup on your machine

After installation, you will have:

```text
~/.vimrc                    # your normal Vim config
~/.vimrc_42                 # 42-only Vim config
~/.vim42/plugin/stdheader.vim
~/.zshrc                    # contains alias vim42='vim -u ~/.vimrc_42'
```

---

## Quick Install

Clone the repo:

```bash
git clone https://github.com/jimjwong/vim42.git
cd vim42
```

Run the installer:

```bash
chmod +x scripts/install.sh
./scripts/install.sh yourLogin yourLogin@student.42.fr
```

Example:

```bash
./scripts/install.sh jimwong jimwong@student.42singapore.sg
```

Refresh your shell:

```bash
source ~/.zshrc
```

Now use:

```bash
vim42 main.c
```

Inside Vim, insert the 42 header with:

```vim
:Stdheader
```

or press:

```text
F1
```

---

## Manual Install

### 1. Create the 42-only plugin folder

```bash
mkdir -p ~/.vim42/plugin
```

### 2. Copy the header plugin

```bash
cp plugin/stdheader.vim ~/.vim42/plugin/stdheader.vim
```

### 3. Create the 42 Vim config

```bash
cp config/vimrc_42.example ~/.vimrc_42
```

Edit it:

```bash
vim ~/.vimrc_42
```

Change:

```vim
let g:user42 = 'yourLogin'
let g:mail42 = 'yourLogin@student.42.fr'
```

to your actual 42 login and email.

### 4. Add the `vim42` alias

For macOS zsh:

```bash
echo "alias vim42='vim -u ~/.vimrc_42'" >> ~/.zshrc
source ~/.zshrc
```

For bash:

```bash
echo "alias vim42='vim -u ~/.vimrc_42'" >> ~/.bashrc
source ~/.bashrc
```

---

## Usage

Open your file with:

```bash
vim42 main.c
```

Insert the header:

```vim
:Stdheader
```

or press:

```text
F1
```

---

## Check that vim42 is isolated

Open normal Vim:

```bash
vim main.c
```

Inside Vim:

```vim
:scriptnames
```

You should **not** see:

```text
stdheader.vim
```

Now open Vim42:

```bash
vim42 main.c
```

Inside Vim:

```vim
:scriptnames
```

You should see something like:

```text
~/.vim42/plugin/stdheader.vim
```

---

## Check Norminette tab settings

Inside `vim42`, run:

```vim
:set noexpandtab?
:set tabstop?
:set shiftwidth?
:set softtabstop?
```

Expected:

```text
noexpandtab
tabstop=4
shiftwidth=4
softtabstop=4
```

This means pressing `Tab` creates a real tab character.

---

## Seeing tabs and trailing spaces

`vim42` displays invisible characters:

```vim
set list
set listchars=tab:>-,trail:·
```

Tabs appear as:

```text
>---
```

Trailing spaces appear as:

```text
·
```

Example:

```c
int	main(void)
{
>---write(1, "hello\n", 6);
>---return (0);
}
```

The `>---` symbol means it is a real tab.

---

## Uninstall

Run:

```bash
chmod +x scripts/uninstall.sh
./scripts/uninstall.sh
```

Then manually remove this line from `~/.zshrc` or `~/.bashrc`:

```bash
alias vim42='vim -u ~/.vimrc_42'
```

Reload your shell:

```bash
source ~/.zshrc
```

---

## Repository structure

```text
vim42/
├── README.md
├── ATTRIBUTION.md
├── LICENSE
├── .gitignore
├── config/
│   └── vimrc_42.example
├── plugin/
│   └── stdheader.vim
└── scripts/
    ├── install.sh
    └── uninstall.sh
```

---

## Attribution

The 42 header functionality and original `stdheader.vim` plugin are provided by the original 42Paris `42header` project:

```text
https://github.com/42Paris/42header
```

This `vim42` project packages that header plugin into an isolated Vim setup for 42 projects.

The main improvement is isolation:

- the 42 header plugin loads only in `vim42`
- 42 identity is stored in `~/.vimrc_42`
- normal Vim remains untouched

Full credit for the 42 header plugin goes to the original `42Paris/42header` project.
