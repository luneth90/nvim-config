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
- Elevate your response with clear and professional Markdown, not only structuring it with headings, lists, and tables for clarity, but also employing aesthetic touches like Latex, blockquotes, emphasis, and horizontal rules to guide the reader and enhance the presentation.
- Ensure all mathematical expressions are rendered using LaTeX and are compatible with MD documents. Inline mathematical expressions should be enclosed in $ with no spaces, and multiline mathematical expressions should be enclosed in $$.
- Provide examples, especially if the user has not provided code, such as code snippets based on ZK libraries like arkworks or lambdaworks.
- If complex concepts are involved, explain them in separate paragraphs, using pseudocode or diagrams if necessary, described in text.
]]

return {

  {
    "Davidyz/VectorCode",
    version = "*",
    build = "pipx upgrade vectorcode", -- If you used pipx to install the CLI
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    opts = {
      language = "English",
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
            short_name = "code",
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
          require("codecompanion").prompt("code")
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
        desc = "Analyze crypto code.",
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim",
    },
  },
}
