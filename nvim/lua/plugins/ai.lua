local system_prompt_info_eng = "I want you, as an English teacher, to help me correct my grammar and word mistakes and correct them in the right way."

local system_prompt_info_js = [[
# 角色设定: ElectronReactPro

**ElectronReactPro** 是一位专门为你的特定项目提供支持的全栈开发专家。

## 核心技术栈

*   **运行时/框架:** Electron
*   **前端:** React (TSX, Functional Components, Hooks), Vite (通过 `@quick-start/electron react-ts` 模板初始化)
*   **语言:** TypeScript (全栈)
*   **UI 库:** shadcn/ui (主要), TailwindCSS (补充/自定义)
*   **包管理器:** pnpm

## 项目结构 (已知)

*   `.` (项目根目录)
    *   `src/`
        *   `main/` (主进程代码)
            *   `index.ts`
            *   `...` (其他主进程文件)
        *   `preload/` (预加载脚本)
            *   `index.ts`
            *   `...` (其他预加载脚本文件)
        *   `renderer/` (渲染进程 - React 应用)
            *   `src/` (React 源代码)
            *   `index.html` (页面入口)
            *   `...` (其他渲染进程文件)
    *   `electron.vite.config.ts` (electron-vite 配置文件)
    *   `package.json` (项目配置文件)
    *   `...` (其他项目文件)

## 核心辅助编程指令

1.  **理解上下文:** 始终牢记上述技术栈和项目结构。所有代码和建议都必须兼容此环境。
2.  **UI 实现:**
    *   **优先使用 shadcn/ui:** 对于任何 UI 元素请求，首先查找并使用官方 `shadcn/ui` 组件。
    *   **组件安装命令:** 特别注意shadcn-ui命令已经废弃，现在只需要shadcn，例如: `pnpm dlx shadcn@latest add ...`。
    *   **TailwindCSS 补充:** 当 `shadcn/ui` 没有提供合适组件或需要高度自定义样式时，使用 TailwindCSS 类。明确指出为何使用 Tailwind。
3.  **Electron 进程间通信 (IPC):**
    *   **安全:** 必须通过 `src/preload/index.ts` (或其他预加载脚本) 使用 `contextBridge.exposeInMainWorld` 安全地暴露功能给渲染进程。绝不直接在渲染进程中 `require('electron')` (除非是 `ipcRenderer` 等少数安全模块)。
    *   **API 设计:** 在 preload 脚本中定义清晰的 API 接口，并在 `src/main/` 中实现对应的 `ipcMain.handle` 或 `ipcMain.on` 逻辑。
    *   **通信模式:**
        *   **优先:** 对于需要响应的异步操作，使用 `ipcRenderer.invoke` (渲染进程) 和 `ipcMain.handle` (主进程)。
        *   **次选:** 对于单向通知或事件，可以使用 `ipcRenderer.send` / `webContents.send` 和 `ipcMain.on` / `ipcRenderer.on`。
    *   **类型安全:** 尽可能为主进程和渲染进程之间的通信提供 TypeScript 类型定义，可以放在共享的类型文件或 preload 脚本中。
4.  **代码生成:**
    *   **语言:** TypeScript。
    *   **风格:** 遵循 React 最佳实践 (函数式组件, Hooks)。代码必须类型安全、可读性高、简洁。
    *   **目录放置:** 明确指出生成的代码片段应该放在哪个目录下（`main`, `preload`, `renderer/src` 的具体子目录）。
    *   **完整性:** 尽量提供完整的、可运行的示例（或关键部分），包括必要的 imports 和类型定义。
5.  **解释:**
    *   对关键代码段、技术选择（尤其是为什么使用某个 shadcn/ui 组件，或为什么需要 IPC）进行简洁明了的解释。
    *   如果涉及到主进程、预加载脚本和渲染进程的交互，要清晰说明数据流和调用关系。
6.  **依赖管理:** 如果代码需要新的 npm 包，明确指出需要使用 `pnpm add <package-name>` 或 `pnpm add -D <package-name>` 安装。

## 响应格式

*   清晰地组织代码块和解释。
*   使用 Markdown 进行格式化。
*   在提供代码前，确认所需信息（例如，具体需要什么组件，数据如何流动）。
]]
local system_prompt_info_rust_en = [[
You are an expert proficient in Zero-Knowledge Proofs, Rust programming, and mathematics. The user wants you to help them understand Rust code related to Zero-Knowledge Proofs step-by-step. Please act as a teacher model and complete the task according to the following requirements:

1. Code Analysis
- Analyze the Rust code provided by the user or assume a typical ZK-related code snippet, such as one involving elliptic curves, finite fields, or the implementation of ZK protocols like zk-SNARKs.
- Break down the code into key parts, explaining the functionality, purpose, and implementation logic line by line or section by section.
- Explain the specific application of the code within a ZK protocol, such as circuit definition, proof generation, or verification.

2. Integration of Mathematical Knowledge
- If the code involves mathematical concepts like finite fields, elliptic curves, polynomial commitments, pairings, etc., clearly explain the relevant mathematical principles.
- Use LaTeX format for mathematical formulas, algebraic expressions, and cryptographic expressions, ensuring all formulas and algebraic expressions can be rendered in Markdown and are compatible with Obsidian.
- Provide derivation processes for formulas, concisely highlighting their connection to the code.

3. Step-by-Step Guidance
- Assume the user has a foundational understanding of ZK and Rust, but not necessarily in-depth knowledge. Use clear and accessible language to guide the user step-by-step through the code and mathematics.
- Provide background knowledge when necessary, such as the working principles of ZK protocols or relevant Rust features like ownership or traits.

4. Output Format
- Organize the response using Markdown format, ensuring a clear structure that includes headings, code blocks, lists, and LaTeX formulas.
- Ensure all mathematical expressions are rendered using LaTeX and are compatible with MD documents. Inline mathematical expressions should be enclosed in $ with no spaces, and multiline mathematical expressions should be enclosed in $$.
- Provide examples, especially if the user has not provided code, such as code snippets based on ZK libraries like arkworks or lambdaworks.
- If complex concepts are involved, explain them in separate paragraphs, using pseudocode or diagrams if necessary, described in text.
]]

local system_prompt_info_rust_cn = [[

你是一个精通零知识证明ZK、Rust 编程和数学的专家。用户希望你帮助他们逐步理解与零知识证明相关的 Rust 代码。请作为教师模型按照以下要求完成任务：

## 1. 代码分析
- 分析用户提供的 Rust 代码或假设一个与 ZK 相关的典型代码片段，例如涉及椭圆曲线、有限域或 ZK 协议如 zk-SNARK 的实现。
- 将代码拆分为关键部分，逐行或逐段解释其功能、作用和实现逻辑。
- 说明代码在 ZK 协议中的具体应用,如电路定义、证明生成、验证等。

## 2. 数学知识结合
- 如果代码涉及数学概念,如有限域、椭圆曲线、多项式承诺、配对等，请清晰解释相关数学原理。
- 使用 LaTeX 格式编写数学公式，代数表达式和密码学表达式，确保所有公式和代数表达式可以在 Markdown中渲染，并兼容 Obsidian。
- 提供公式的推导过程，简明扼要，突出与代码的关联。

## 3. 逐步引导
- 假设用户对 ZK 和 Rust 有一定基础，但不一定深入。使用通俗易懂的语言，逐步引导用户理解代码和数学。
- 必要时提供背景知识,如 ZK 协议的工作原理、Rust 的相关特性如所有权或 trait。

## 4. 输出格式
- 使用 Markdown 格式组织回答，确保结构清晰，包含标题、代码块、列表和 LaTeX 公式。
- 确保所有数学表达式使用LaTex渲染，并且兼容MD文档,行内数学表达式使用$包裹并且不允许有空格，多行数学表达式使用$$包裹。
- 提供示例,如果用户未提供代码，如基于 arkworks 或 lambdaworks 等 ZK 库的代码片段。
- 如果涉及复杂概念，分段落解释，必要时使用伪代码或图表,以文本描述。

]]

return {

  {
    "Davidyz/VectorCode",
    version = "*",
    build = "uv tool upgrade vectorcode", -- This helps keeping the CLI up-to-date
    -- build = "pipx upgrade vectorcode", -- If you used pipx to install the CLI
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    opts = {
      language = "Chinese",
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = "GEMINI_API_KEY",
            },
          })
        end,
        openrouter = function()
          local openrouter = require("codecompanion.utils.openrouter")
          return require("codecompanion.adapters").extend(openrouter, {
            name = "openrouter",
            formatted_name = "Open Router",
            env = {
              url = "https://openrouter.ai/api",
              api_key = "OPENROUTER_API_KEY",
            },
            schema = {
              model = {
                --default = "openai/gpt-oss-120b",
                --default = "openai/gpt-5-chat",
                default = "qwen/qwen3-coder",
                --default = "google/gemini-2.5-pro",
              },
            },
          })
        end,
      },
      prompt_library = {
        ["Crypto tutor"] = {
          strategy = "chat",
          description = "Chat with your personal crypto tutor",
          opts = {
            mapping = "<leader>cc",
            modes = { "n" },
            short_name = "crypto",
            index = 4,
            ignore_system_prompt = true,
            intro_message = "Welcome to your lesson! How may I help you today? ",
          },
          prompts = {
            {
              role = "system",
              content = system_prompt_info_rust_en,
            },
          },
        },
        ["Code Expert"] = {
          strategy = "chat",
          description = "Get some special advice from an LLM",
          opts = {
            mapping = "<leader>ce",
            modes = { "v" },
            short_name = "expert",
            auto_submit = true,
            stop_context_insertion = true,
            user_prompt = true,
          },
          prompts = {
            {
              role = "system",
              content = function(context)
                return "I want you to act as a senior "
                  .. context.filetype
                  .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
              end,
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              }
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
            --model = "openai/gpt-oss-120b",
            --model = "openai/gpt-5-chat",
            --model = "qwen/qwen3-coder",
          },
        },
        inline = {
          adapter = {
            name = "gemini",
            model = "gemini-2.5-pro",
            --model = "openai/gpt-5-chat",
            --model = "openai/o4-mini-high",
            --model = "openai/gpt-oss-120b",
            --model = "qwen/qwen3-coder",
          },
        },
      },

      extensions = {
        history = {
            enabled = true,
            opts = {
                -- Keymap to open history from chat buffer (default: gh)
                keymap = "gh",
                -- Keymap to save the current chat manually (when auto_save is disabled)
                save_chat_keymap = "sc",
                -- Save all chats by default (disable to save only manually using 'sc')
                auto_save = true,
                -- Number of days after which chats are automatically deleted (0 to disable)
                expiration_days = 0,
                -- Picker interface (auto resolved to a valid picker)
                picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default") 
                ---Optional filter function to control which chats are shown when browsing
                chat_filter = nil, -- function(chat_data) return boolean end
                -- Customize picker keymaps (optional)
                picker_keymaps = {
                    rename = { n = "r", i = "<M-r>" },
                    delete = { n = "d", i = "<M-d>" },
                    duplicate = { n = "<C-y>", i = "<C-y>" },
                },
                ---Automatically generate titles for new chats
                auto_generate_title = true,
                title_generation_opts = {
                    ---Adapter for generating titles (defaults to current chat adapter) 
                    adapter = nil, -- "copilot"
                    ---Model for generating titles (defaults to current chat model)
                    model = nil, -- "gpt-4o"
                    ---Number of user prompts after which to refresh the title (0 to disable)
                    refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                    ---Maximum number of times to refresh the title (default: 3)
                    max_refreshes = 3,
                    format_title = function(original_title)
                        -- this can be a custom function that applies some custom
                        -- formatting to the title.
                        return original_title
                    end
                },
                ---On exiting and entering neovim, loads the last chat on opening chat
                continue_last_chat = false,
                ---When chat is cleared with `gx` delete the chat from history
                delete_on_clearing_chat = false,
                ---Directory path to save the chats
                dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                ---Enable detailed logging for history extension
                enable_logging = false,

                -- Summary system
                summary = {
                    -- Keymap to generate summary for current chat (default: "gcs")
                    create_summary_keymap = "gcs",
                    -- Keymap to browse summaries (default: "gbs")
                    browse_summaries_keymap = "gbs",
                    
                    generation_opts = {
                        adapter = nil, -- defaults to current chat adapter
                        model = nil, -- defaults to current chat model
                        context_size = 90000, -- max tokens that the model supports
                        include_references = true, -- include slash command content
                        include_tool_outputs = true, -- include tool execution results
                        system_prompt = nil, -- custom system prompt (string or function)
                        format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
                    },
                },
                
                -- Memory system (requires VectorCode CLI)
                memory = {
                    -- Automatically index summaries when they are generated
                    auto_create_memories_on_summary_generation = true,
                    -- Path to the VectorCode executable
                    vectorcode_exe = "vectorcode",
                    -- Tool configuration
                    tool_opts = { 
                        -- Default number of memories to retrieve
                        default_num = 10 
                    },
                    -- Enable notifications for indexing progress
                    notify = true,
                    -- Index all existing memories on startup
                    -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
                    index_on_startup = false,
                },
            }
        },
        vectorcode = {
          opts = {
            tool_group = {
              -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
              enabled = true,
              -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
              -- if you use @vectorcode_vectorise, it'll be very handy to include
              -- `file_search` here.
              extras = {},
              collapse = false, -- whether the individual tools should be shown in the chat
            },
            tool_opts = {
              ---@type VectorCode.CodeCompanion.ToolOpts
              ["*"] = {},
              ---@type VectorCode.CodeCompanion.LsToolOpts
              ls = {},
              ---@type VectorCode.CodeCompanion.VectoriseToolOpts
              vectorise = {},
              ---@type VectorCode.CodeCompanion.QueryToolOpts
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                no_duplicate = true,
                chunk_mode = false,
                ---@type VectorCode.CodeCompanion.SummariseOpts
                summarise = {
                  ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                  enabled = false,
                  adapter = nil,
                  query_augmented = true,
                }
              },
              files_ls = {},
              files_rm = {}
            }
          },
        },
      },
    },
    keys = {
      {
        "<C-a>",
        "<cmd>CodeCompanionActions<CR>",
        desc = "Open the action palette",
        mode = { "n", "v" },
      },
      {
        "<leader>ct",
        "<cmd>CodeCompanionChat Toggle<CR>",
        desc = "Toggle a chat buffer",
      },
      {
        "<leader>ca",
        "<cmd>CodeCompanionChat Add<CR>",
        desc = "Add code to a chat buffer",
        mode = { "n", "v" },
      },
      {
        "<leader>ce", 
        function()
          require("codecompanion").prompt("expert")
        end, 
        mode = {"n","v" },
        desc = "Explain code.",
      },
      {
        "<leader>cc", 
        function()
          require("codecompanion").prompt("crypto")
        end, 
        mode = {"n"},
        desc = "Analysis crypto code.",
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
  },

  --[[
  { 
    "yetone/avante.nvim", 
    version = false, -- Never set this value to "*"! Never!
    event = "VeryLazy", 
    opts = {
      windows = {
        position = "right", -- 侧边栏位置
        wrap = true,
        width = 40, -- 侧边栏宽度，占屏幕百分比（如 40%）
        height = 30, -- 侧边栏高度，占屏幕百分比（仅在 position 为 top/bottom 时有效）
        input = {
          height = 8, -- 输入窗口高度（垂直布局）
        },
      },
      -- gemini
      provider = "gemini",
      system_prompt = system_prompt_info_rust_en,
      providers = {
        gemini= {
            model = 'gemini-2.5-pro',
            proxy = "http://127.0.0.1:6152", -- proxy support, e.g., http://127.0.0.1:7890
            timeout = 30000000,
            temperature = 0,
            max_tokens = 1000000,
        },
        openrouter = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'qwen/qwen3-coder',
          proxy = "http://127.0.0.1:6152", -- proxy support, e.g., http://127.0.0.1:7890
          timeout = 30000000,
          max_tokens = 1000000,
        },
        qwen = {
          __inherited_from = "openai",
          api_key_name = "DASHSCOPE_API_KEY",
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          model = "qwen3-coder-plus",
        },
      },
      rag_service = { -- RAG Service configuration
        enabled = false, -- Enables the RAG service
        host_mount = "/Users/luneth/code/rust/lambdaworks/crates/",
        runner = "docker", -- Runner for the RAG service (can use docker or nix)
        llm = { -- Language Model (LLM) configuration for RAG service
          provider = "dashscope", -- LLM provider
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          api_key = "DASHSCOPE_API_KEY", -- Environment variable name for the LLM API key
          model = "qwen3-coder-plus", -- LLM model name
          proxy = "http://127.0.0.1:6152", -- proxy support, e.g., http://127.0.0.1:7890
          extra = nil, -- Additional configuration options for LLM
        },
        embed = { -- Embedding model configuration for RAG service
          provider = "dashscope", -- Embedding provider
          endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
          api_key = "DASHSCOPE_API_KEY", -- Environment variable name for the LLM API key
          model = "text-embedding-v4", -- The Embedding model name (e.g., "text-embedding-v2")
          proxy = "http://127.0.0.1:6152", -- proxy support, e.g., http://127.0.0.1:7890
          extra = { -- Extra configuration options for the Embedding model (optional)
            embed_batch_size = 10,
          },
        },
        docker_extra_args = "", -- Extra arguments to pass to the docker command
      },
    },
    build = "make", 
    dependencies = { 
      "nvim-treesitter/nvim-treesitter", 
      "stevearc/dressing.nvim", 
      "nvim-lua/plenary.nvim", 
      "MunifTanjim/nui.nvim", 
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    }, 
    keys = {
      { "<leader>aa", ":AvanteAsk<CR>", desc = "Ask Avante" },
      { "<leader>at", ":AvanteToggle<CR>", desc = "toggle Avante" },
      { "<leader>ae", ":AvanteEdit<CR>", desc = "Edit with Avante" },
      { "<leader>ar", ":AvanteRefresh<CR>", desc = "Refresh Avante" },
      { "<leader>aC", ":AvanteClear<CR>", desc = "Clear Avante" },
      { "<leader>an", ":AvanteChatNew<CR>", desc = "New Chat Avante" },
      { "<leader>af", ":AvanteFocus<CR>", desc = "Focus Avante" },
      { "<leader>ah", ":AvanteHistory<CR>", desc = "History Avante" },
      {
            "<leader>a+",
            function()
                local tree_ext = require("avante.extensions.nvim_tree")
                tree_ext.add_file()
            end,
            desc = "Select file in NvimTree",
            ft = "NvimTree",
        },
        {
            "<leader>a-",
            function()
                local tree_ext = require("avante.extensions.nvim_tree")
                tree_ext.remove_file()
            end,
            desc = "Deselect file in NvimTree",
            ft = "NvimTree",
        },
    },
  },
  ]]--

}
