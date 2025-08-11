    local bufferline = require('bufferline')
    bufferline.setup {
        options = {
			mode = "buffers",
            numbers = "buffer_id",
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center",
					highlight = "Directory",
                    separator =  true
                }
            },
            color_icons = true,
        }
    }
