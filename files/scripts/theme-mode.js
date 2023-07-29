// Shortcut: control ;
// Name: theme mode

import "@johnlindquist/kit"

await exec(`osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'`)