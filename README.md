# Modern Neovim Configuration

A feature-rich, modular Neovim configuration optimized for web development with first-class TypeScript/JavaScript support. This setup provides an IDE-like experience while maintaining Neovim's speed and extensibility.

## ✨ Key Features

### Editor Experience

-   🤖 AI-powered coding assistance (GitHub Copilot, CodeCompanion)
-   🎨 Modern UI with Rose Pine theme
-   📊 Informative statusline with LSP integration
-   🔍 Fuzzy finding for files, text, and commands
-   📝 Advanced syntax highlighting with Treesitter
-   🔧 VSCode-like experience with optional VSCode Neovim integration

### Development Features

-   🚀 First-class TypeScript/JavaScript support
-   ✨ Intelligent code completion and snippets
-   🔍 Built-in LSP with advanced features
-   🎯 Automatic formatting and linting
-   🔄 Git integration

## 🛠️ Prerequisites

-   Neovim >= 0.9.0
-   Git
-   Node.js >= 18.x (for LSP features and Copilot)
-   A Nerd Font (for icons)
-   ripgrep (for fuzzy finding)
-   Optional: VSCode (for VSCode Neovim integration)

## 📦 Installation

1. **Backup your existing configuration**:

    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    ```

2. **Clone this configuration**:

    ```bash
    git clone https://github.com/amahmod/nvim.git ~/.config/nvim
    ```

3. **Install plugins**:

    - Launch Neovim
    - The plugin manager will automatically install required plugins
    - Wait for installation to complete

4. **Setup Language Servers**:

    - LSP servers will be automatically installed on first launch
    - Required formatters and linters will be installed via Mason

## ⌨️ Key Mappings

### General

-   `<Space>` - Leader key
-   `<leader>w` - Save file
-   `<leader>q` - Quit
-   `<C-s>` - Save file (works in all modes)

### Navigation

-   `<C-h/j/k/l>` - Window navigation
-   `<S-l/h>` - Next/previous buffer
-   `<leader>e` - Toggle file explorer

### Code Actions

-   `gd` - Go to definition
-   `gr` - Find references
-   `K` - Show hover information
-   `<leader>ca` - Code actions
-   `<leader>rn` - Rename symbol
-   `[d/]d` - Previous/next diagnostic
-   `<leader>lf` - Format document

### AI Features

-   `<C-a>` - CodeCompanion actions
-   `<leader>a` - Toggle CodeCompanion chat
-   `<Tab>` - Accept Copilot suggestion

### Git

-   `<leader>gg` - Open Lazygit
-   `<leader>gd` - View git diff
-   `<leader>gb` - View git branches

## 📁 Configuration Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── autocmds.lua        # Autocommands
│   ├── options.lua         # Neovim options
│   ├── mappings.lua        # Key mappings
│   ├── plugins/
│   │   ├── ai_completion/  # AI tools configuration
│   │   ├── lsp.lua        # LSP configuration
│   │   ├── statusline/    # Status line configuration
│   │   └── ...
│   └── vscode_neovim_config/ # VSCode Neovim integration
```

## 🎨 Customization

The configuration is modular and easy to customize:

1. Add/modify plugins in `lua/plugins/`
2. Adjust key mappings in `lua/mappings.lua`
3. Change editor options in `lua/options.lua`
4. Modify LSP settings in `lua/plugins/lsp.lua`

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.
