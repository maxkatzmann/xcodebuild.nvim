---@mod xcodebuild.requirements Requirements
---@tag xcodebuild.tools
---@tag xcodebuild.dependencies
---@brief [[
---Neovim environment
--- - `Neovim 0.9.5+`
--- - `telescope.nvim` to present pickers.
--- - `nui.nvim` to present floating code coverage report.
--- - `snacks.nvim` to show previews for SwiftUI, UIKit, and AppKit views.
--- - `nvim-tree`, `neo-tree.nvim`, or `oil.nvim` to visually manage your project files.
--- - `nvim-dap` and `nvim-dap-ui` to debug apps.
--- - `nvim-treesitter` + Swift parser to show test results for tests written using `Quick` framework.
---
---External tools
--- - `xcbeautify` to format Xcode logs (you can set a different tool or disable formatting in the config).
--- - `Xcodeproj` to manage project files within Neovim.
--- - `Ruby` to use `Xcodeproj` gem.
--- - `pymobiledevice3` to debug on physical devices and/or run apps on devices below iOS 17.
--- - `jq` to get some information from `pymobiledevice3`.
--- - `xcode-build-server` to make LSP work properly with xcodeproj/xcworkspace.
--- - `codelldb` to debug applications.
--- - `ripgrep` to find matching test files while using Swift Testing framework.
--- - `Xcode` to build, run, and test apps. Make sure that `xcodebuild` and `xcrun simctl` work correctly. Tested with Xcode 15.
---
---Installation
--->bash
---  brew install xcode-build-server xcbeautify ruby pipx rg jq coreutils
---  gem install xcodeproj
---  pipx install pymobiledevice3
---<
---
---To quickly install all required tools you can run:
--->bash
---  cd ~/.local/share/nvim/lazy/xcodebuild.nvim
---  make install
---<
---
---To debug on physical devices with iOS 17+ you will need to set up `sudo`,
---see |xcodebuild.ios17| to learn more.
---
---@brief ]]

local M = {}
return M
