========
zdict.sh
========

zdict is a command line utility, it DOES need some completion scripts.

Install - zsh
-------------

* Create a directory for your completion files, for example ``~/.zsh/completions``
* Put ``_zdict`` into ``~/.zsh/completions``
* Make sure ``~/.zsh/completions`` is in your ``$fpath`` environment variable, you can set it in your ``.zshrc`` like ::

    fpath=($HOME/.zsh/completions $fpath)
