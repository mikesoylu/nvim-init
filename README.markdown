## Vim dotfiles

These are the vim runtime files that I use on a daily basis. Feel free to clone, modify, change, add, murder or remove portions of it at will.

I used to be a heavy advocate and user of [Pathogen](https://github.com/tpope/vim-pathogen) by the most excellent Tim Pope, but I have recently
switched to [Vundle](https://github.com/gmarik/vundle), because I got tired of futzing around with git submodules every time I wanted to update
or remove a bundle, but I still wanted a way of controlling my entire Vim runtime from some centralized source. Vundle seems to hit all the right
sweet spots.

## Usage

**NOTE**: If you have existing files in `$HOME/.vim` or `$HOME/.vimrc`, make sure you take appropriate backups before performing any of the following steps.

 - First get my vim-dotfiles & symlink the `.vimrc` to your `$HOME/.vimrc`:

```sh
$ git clone git@github.com:mikesoylu/vim-dotfiles.git ~/.vim && ln -s ~/.vim/.vimrc ~/.vimrc
```

 - Next, install Vundle, as per their [instructions](https://github.com/gmarik/vundle):

```sh
$ git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
```

 - Finally, we need to launch Vim and then invoke the appropriate Vundle commands to install all of the bundles using the `:BundleInstall` command.

And that's it! Be sure to source your newly installed configuration (`:source $MYVIMRC` from inside Vim, or just restart a new editor session), and you should be good to go.

The included `.vimrc` contains some very minimal configurations that should be sane defaults for most developers, including a colorscheme that is pulled from one of the installed
bundles. Feel free to modify at will, of course. See the comments in the `.vimrc` file for more details, and check out the individual bundles that are pulled in on github until
I decide to annotate & comment on what each of them do.

