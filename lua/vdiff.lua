vim.api.nvim_create_user_command("Diff", function()
    local original = vim.fn.maparg("<Enter>", "n", false, true)
    local original_v = vim.fn.maparg("<Enter>", "v", false, true)
    vim.keymap.set({ "n", "v" }, "<Enter>", function()
        local a_saved = vim.fn.getreg("a")
        local a_saved_type = vim.fn.getregtype("a")
        if vim.fn.mode() == "n" then
            vim.cmd("normal! gv\"ay")
        else
            vim.api.nvim_feedkeys("\"ay", "nx", true)
        end
        vim.keymap.set({ "n", "v" }, "<Enter>", function()
            if vim.fn.mode() == "n" then
                vim.cmd("normal! gvy")
            else
                vim.api.nvim_feedkeys("y", "nx", true)
            end
            vim.cmd("enew")
            vim.cmd("normal! p")
            vim.cmd("new")
            vim.cmd("normal! \"ap")
            vim.cmd("windo diffthis")
            if original.rhs then
                vim.keymap.set("n", "<Enter>", original.rhs, {
                    noremap = original.noremap,
                    silent = original.silent,
                    script = original.script,
                    expr = original.expr,
                    buffer = original.buffer,
                    nowait = original.nowait,
                })
            else
                vim.keymap.del("n", "<Enter>")
            end
            if original_v.rhs then
                vim.keymap.set("v", "<Enter>", original_v.rhs, {
                    noremap = original_v.noremap,
                    silent = original_v.silent,
                    script = original_v.script,
                    expr = original_v.expr,
                    buffer = original_v.buffer,
                    nowait = original_v.nowait,
                })
            else
                vim.keymap.del("v", "<Enter>")
            end
            vim.fn.setreg("a", a_saved, a_saved_type)
        end, {})
    end, {})
end, {})

local M = {}

M.setup = function(opts)
end

return M
