## Vim dotfiles

These are the vim/neovim runtime files that I use on a daily basis. Feel free to clone, modify, change, add, murder or remove portions of it at will.

## Usage

**NOTE**: If you have existing files in `$HOME/.vim` or `$HOME/.vimrc`, make sure you take appropriate backups before performing any of the following steps.

1. Get my vim-dotfiles & symlink the `.vimrc` to your `$HOME/.vimrc`:

```sh
$ git clone git@github.com:mikesoylu/vim-dotfiles.git ~/.vim && ln -s ~/.vim/.vimrc ~/.vimrc
```

2. Create directory `$HOME/.config` if not there already & symlink the `nvim` to your `$HOME/.vim`:

```sh
$ mkdir ~/.config; ln -s ~/.vim ~/.config/nvim
```

3. Install NeoBundle, as per their [instructions](https://github.com/Shougo/neobundle.vim#quick-start):

```sh
$ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
$ sh ./install.sh
```

4. Install FZF [instructions](https://github.com/junegunn/fzf#installation):

```sh
$ brew install fzf
```

5. Install ag [instructions](https://github.com/ggreer/the_silver_searcher#installing):

```sh
$ brew install the_silver_searcher
```

6. Finally, we need to launch Vim and then invoke the appropriate NeoBundle commands to install all of the bundles using the `:NeoBundleInstall` command.

And that's it! Be sure to source your newly installed configuration (`:source $MYVIMRC` from inside Vim, or just restart a new editor session), and you should be good to go.

