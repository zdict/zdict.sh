========
zdict.sh
========
zdict is a command line utility, it DOES need some completion scripts.

Install - zsh
--------------

Install with `antigen <https://github.com/zsh-users/antigen>`_
````````````````````````````````````````````````````````````````
Use `antigen <https://github.com/zsh-users/antigen>`_ to install this zsh plugin ::

  source path-to-antigen-script/antigen.zsh
  antigen bundle zdict/zdict.sh
  antigen apply

Install by hand
`````````````````
* Completion Script

  A)  Prepare a folder for zsh completion scripts, e.g. ``$HOME/.completions``
  B)  Make sure completion folder is in ``$fpath`` ::

        # In your .zshrc
        fpath=($HOME/.completions $fpath)

  C)  Put ``_zdict`` into completion folder

* Query helper with tmux ::

    # In your .zshrc
    source path-to-plugin-script/zdict.plugin.zsh
