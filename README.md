# dotfiles
Home for my non-sensitive dotfiles.

## How to use it?

If you are using Ubuntu (that's the distro I use) you can simply execute the next commands:
```
$ git clone https://github.com/davidmogar/dotfiles.git
$ cd dotfiles
$ ./prerequisites.sh
```

> Note: The script creates a .xproperties file to set up my monitors. You **should not use** this config so it's better to comment the next line before execute the script:
> ```bash
cp -R "${DOTFILES}".xproperties ~
```
> You will also need to set up correct values in `~/.config/i3/config` for your monitors setup.

If not the case, just copy the files to the right paths ;)
