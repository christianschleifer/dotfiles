-- Herdr prefix bindings.
rex.bind("\\>g", "session.switch")
rex.bind("\\>w", "session.switch")
rex.bind("\\>c", "client.tab.new")
rex.bind("\\>,", "client.tab.rename")
rex.bind("\\>h", "pane.focus", { direction = "left" })
rex.bind("\\>j", "pane.focus", { direction = "down" })
rex.bind("\\>k", "pane.focus", { direction = "up" })
rex.bind("\\>l", "pane.focus", { direction = "right" })
rex.bind("\\>v", "pane.split", { direction = "right" })
rex.bind("\\>s", "pane.split", { direction = "down" })

-- Press the prefix twice to send a literal backslash.
rex.bind("\\>\\", "pane.send_key", { key = "\\" })

-- Numbered tabs use the Herdr prefix instead of Cmd+number.
for index = 1, 9 do
  rex.bind("cmd+[Digit" .. index .. "]", "pane.send_key", { key = "cmd+" .. index })
  rex.bind("\\>" .. index, "client.tab.goto", { index = index })
end

-- Activity overview.
rex.bind("\\>.", "client.sidebar.activity.toggle")
