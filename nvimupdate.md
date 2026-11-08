# NixOS Configuration Updates for Neovim 0.12.6

This document describes the changes needed in `/home/rick/nixconfiguration` (specifically `core/home/neovim.nix` and optionally `core/home/tmux.nix`) to support the updated Neovim `0.12.6` configuration in `~/dotfiles/.config/nvim`.

---

## 1. Update `core/home/neovim.nix`

### Why these changes are needed:
1. **Formatters for `conform.nvim`**: Neovim is configured to format code on save using `prettier` (for JS/TS/Vue/HTML/CSS/JSON/YAML/Markdown) and `stylua` (for Lua), plus `nixfmt` (for Nix). Currently, `prettier` and `stylua` are missing from `home.packages`.
2. **Build tools for `nvim-treesitter` (`main` branch) & `telescope-fzf-native.nvim`**: The new `nvim-treesitter` `main` branch compiles parsers using `tree-sitter` CLI + a C compiler (`gcc`), and `telescope-fzf-native.nvim` builds with `make`. Having `gcc` and `gnumake` in `home.packages` ensures parser compilation and plugin builds succeed seamlessly.
3. **`jsregexp` for `LuaSnip`**: Instead of having `LuaSnip` attempt to run `make install_jsregexp` inside the lazy.nvim plugin directory, NixOS Home Manager can provide `jsregexp` directly to Neovim's Lua runtime via `programs.neovim.extraLuaPackages`.

### Target File: `/home/rick/nixconfiguration/core/home/neovim.nix`

Replace the contents of `core/home/neovim.nix` with:

```nix
{
  config,
  pkgs,
  lib,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in
{
  home.packages = with pkgs; [
    # Language Servers
    lua-language-server
    typescript-language-server
    vue-language-server
    bash-language-server
    sqls
    nil # nix LSP
    yaml-language-server
    clang-tools # provides clangd

    # Formatters & Linters (used by conform.nvim)
    prettier # or nodePackages.prettier depending on nixpkgs channel
    stylua
    nixfmt

    # Build tools required by nvim-treesitter (main branch) and telescope-fzf-native
    gcc
    gnumake
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    withRuby = false;
    withPython3 = false;
    extraLuaPackages = ps: [
      ps.jsregexp # Required by LuaSnip for LSP snippet variable/placeholder transformations
    ];
  };

  xdg.configFile."nvim/init.lua".enable = lib.mkForce false;
  xdg.configFile."nvim" = {
    source = create_symlink "${dotfiles}/.config/nvim";
    # recursive = true;
  };
}
```

> **Note on `prettier` package name**: In modern `nixos-unstable`, `pkgs.prettier` or `pkgs.nodePackages.prettier` is available. Verify which attribute evaluates cleanly with `nix eval` when rebuilding.

---

## 2. Optional: Fix Tmux `$TERM` Healthcheck Warning in `core/home/tmux.nix`

### Why this change is needed:
Running `:checkhealth` in Neovim inside Tmux currently reports:
`ERROR: $TERM differs from the tmux default-terminal setting. Colors might look wrong. ($TERM: xterm-256color, default-terminal: screen-256color)`

### Target File: `/home/rick/nixconfiguration/core/home/tmux.nix`

Add `terminal = "tmux-256color";` (or `"xterm-256color"`) inside `programs.tmux`:

```nix
  programs.tmux = {
    enable = true;

    # Basic configuration
    baseIndex = 1;
    escapeTime = 50;
    mouse = true;
    keyMode = "vi";
    terminal = "tmux-256color";
```

---

## 3. Clean Up Dead Apex Comments (Optional)

Since Apex is no longer used:
- In `/home/rick/nixconfiguration/flake.nix`: You can remove the commented-out `# sfdx` and `# apex-ls` inputs (lines 14-17 and 34).
- In `/home/rick/nixconfiguration/core/config/packages.nix`: You can remove the commented-out `# inputs.sfdx...` and `# inputs.apex-ls...` lines (lines 48 and 60).
