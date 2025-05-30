---@mod xcodebuild.integrations.ios17 Debugging On iOS 17+ Device
---@tag xcodebuild.ios17
---@tag xcodebuild.remote-debugger
---@brief [[
---
---Since iOS 17, a new secure connection between Mac and mobile devices is
---required. Xcodebuild.nvim uses `pymobiledevice3` to establish a special
---trusted tunnel that is later used for debugging. However, this operation
---requires `sudo`.
---
---Showing a pop-up to enter a password every time you run a debugger would
---be quite annoying. That's why the plugin provides a small script
---`tools/remote_debugger` that wraps the only two operations requiring
---`sudo` (starting a secure tunnel and closing it).
---
---This allows you to configure passwordless access just for this single
---file and make it work with xcodebuild.nvim.
---
---⚠️ CAUTION
---Giving passwordless `sudo` access to that file, potentially opens a gate for
---malicious software that could modify the file and run some evil code using
---`root` account. The best way to protect that file is to create a local copy,
---change the owner to `root`, and give write permission only to `root`.
---The same must be applied to the parent directory. The script below
---automatically secures the file.
---
---👉 Enable integration
---
---Update your config with:
--->lua
---  integrations = {
---    pymobiledevice = {
---      enabled = true,
---    },
---  }
---<
---
---👉 Run the following command to install & protect the script
---
--->bash
---  DEST="$HOME/Library/xcodebuild.nvim" && \
---    SOURCE="$HOME/.local/share/nvim/lazy/xcodebuild.nvim/tools/remote_debugger" && \
---    ME="$(whoami)" && \
---    sudo install -d -m 755 -o root "$DEST" && \
---    sudo install -m 755 -o root "$SOURCE" "$DEST" && \
---    sudo bash -c "echo \"$ME ALL = (ALL) NOPASSWD: $DEST/remote_debugger\" >> /etc/sudoers"
---<
---
---See also: https://github.com/doronz88/pymobiledevice3/blob/master/misc/RemoteXPC.md#trusted-tunnel
---
---@brief ]]
---
---@tag xcodebuild.remote-debugger-migration
---@brief [[
---
---Previous version of xcodebuild.nvim asked you to give sudo permission to:
---`$HOME/.local/share/nvim/lazy/xcodebuild.nvim/tools/remote_debugger`
---
---Unfortunately, it's not the best solution, because someone could modify
---that file and run some evil code using `root` account.
---
---Therefore, to improve security, please run `sudo visudo -f /etc/sudoers` and
---remove previously added line with `remote_debugger` path.
---
---After that, run the script that is presented above to securely install
---`pymobiledevice3` integration. See: |xcodebuild.remote-debugger|.
---
---The script installed in a new way will be protected and the modification
---of the file will be allowed only for the `root` user.
---
---Please also note that remote debugger config options have been moved to:
---`integrations.pymobiledevice`.
---
---@brief ]]
---
---@tag xcodebuild.remote-debugger-update
---@brief [[
---To update the `remote_debugger` script, you can run:
---
--->bash
--- DEST="$HOME/Library/xcodebuild.nvim" && \
---    SOURCE="$HOME/.local/share/nvim/lazy/xcodebuild.nvim/tools/remote_debugger" && \
---    sudo install -m 755 -o root "$SOURCE" "$DEST"
---<
---@brief ]]

local M = {}
return M
