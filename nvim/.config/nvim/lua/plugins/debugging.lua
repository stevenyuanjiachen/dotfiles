return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
    },

    config = function()
        require("dapui").setup()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- keymaps
        vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
        vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
        vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")

        -- C++ Config
        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = os.getenv("HOME") .. "/tools/vscode-cpptools/extension/debugAdapters/bin/OpenDebugAD7",
        }
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",

                program = function()
                    -- 获取当前文件的路径
                    local current_file = vim.fn.expand('%:p')  -- 当前文件的绝对路径
                    local output_file = vim.fn.fnamemodify(current_file, ':r') .. '.out'  -- 编译后生成的可执行文件路径（去掉 .cpp 后缀并加上 .out）

                    -- 编译命令
                    local compile_command = string.format("g++ -g -o %s %s", output_file, current_file)
                    vim.fn.system(compile_command)  -- 编译当前文件

                    return output_file  -- 返回生成的可执行文件路径供调试使用
                end,

                cwd = "${workspaceFolder}",
                stopAtEntry = true,
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "Enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
        }
    end,
}
