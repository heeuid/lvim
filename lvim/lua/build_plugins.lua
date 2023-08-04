local merge_plugin_set = function(new_table)
    local start_k = #lvim.plugins
    for k, v in pairs(new_table) do
        lvim.plugins[start_k + k] = v
    end
end

merge_plugin_set(require("plugins.common"))
merge_plugin_set(require("plugins.rust"))
merge_plugin_set(require("plugins.linux"))
merge_plugin_set(require("plugins.flutter"))
