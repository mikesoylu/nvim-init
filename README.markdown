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

3. Install vim-plug, as per their [instructions](https://github.com/junegunn/vim-plug):

```sh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

4. Install ag + ripgrep:

```sh
$ brew install the_silver_searcher
$ brew install ripgrep
```

5. Finally, we need to launch Vim and install plugins using the `:PlugInstall` command.

And that's it! Be sure to source your newly installed configuration (`:source $MYVIMRC` from inside Vim, or just restart a new editor session), and you should be good to go.

