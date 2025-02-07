require "baggage".from 'https://github.com/Wansmer/treesj'

local attribute_toggle = function(node_type, parent_type)
  return {
    both = {
      enable = function(tsn)
        return tsn:parent():type() == parent_type
      end,
    },
    split = {
      format_tree = function(tsj)
        local str = tsj:child(node_type)
        local words = vim.split(str:text(), ' ')
        tsj:remove_child(node_type)
        for i, word in ipairs(words) do
          tsj:create_child({ text = word }, i + 1)
        end
      end,
    },
    join = {
      format_tree = function(tsj)
        local str = tsj:child(node_type)
        local node_text = str:text()
        tsj:remove_child(node_type)
        tsj:create_child({ text = node_text }, 2)
      end,
    }
  }
end

require 'treesj'.setup({
  use_default_keymaps = false,
  max_join_length = 500,
  cursor_behavior = 'start',
  notify = true,
  langs = {
    -- use :InspectTree
    -- [ <the node the cursor is on> ] = attribute_toggle(<node to toggle>, <is below this parent node>)
    elixir = {
      quoted_content = {
        both = {
          enable = function(tsn)
            return tsn:parent():type() == 'expression_value'
          end,
        },
        split = {
          format_tree = function(tsj)
            local str = tsj:child('string')
            local words = vim.split(str:text(), ' ')
            tsj:remove_child('string')
            for i, word in ipairs(words) do
              tsj:create_child({ text = word }, i + 1)
            end
          end,
        },
        join = {
          format_tree = function(tsj)
            local str = tsj:child('quoted_content')
            local node_text = str:text()
            tsj:remove_child('quoted_content')
            tsj:create_child({ text = node_text }, 2)
          end,
        }
      },
      quoted_attribute_value = attribute_toggle('attribute_value', 'attribute'),
    },
    php    = {
      attribute_value = attribute_toggle('attribute_value', 'quoted_attribute_value')
    },
    heex   = {
      quoted_attribute_value = attribute_toggle('attribute_value', 'attribute')
    },
    tsx    = {
      string = attribute_toggle('string_fragment', 'jsx_attribute'),
      template_string = attribute_toggle('template_string', 'expression_statement')
    },
    astro  = {
      quoted_attribute_value = attribute_toggle('attribute_value', 'attribute')
    },
    html   = { ['quoted_attribute_value'] = attribute_toggle('attribute_value', 'attribute') },
  },
  ---@type boolean Use `dot` for repeat action
  dot_repeat = true,
  ---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
  on_error = nil,
})

vim.keymap.set({ "n" }, "<leader>m", function() require 'treesj'.toggle() end)
vim.keymap.set({ "n" }, "<leader>m", function() require 'treesj'.toggle() end)
