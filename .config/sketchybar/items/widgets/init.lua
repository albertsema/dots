require "items.widgets.volume"
require "items.widgets.wifi"
-- require "items.widgets.battery"

sbar.add("bracket", { "/widgets\\..*/" }, {})

sbar.add("item", "widget.padding", {
  position = "right",  -- Add position
  width = 16,
  drawing = true,      -- Explicitly set drawing
})
