local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local trim = function(str)
	return (str:gsub("^%s*(.-)%s*$", "%1"))
end

local getGitUser = function()
	local email = vim.fn.system({ "git", "config", "user.email" })
	local name = vim.fn.system({ "git", "config", "user.name" })
	return string.format("%s <%s>", trim(name), trim(email))
end

local createNSTag = function(version, type)
	return fmt(
		[[
                /**
                 * {} 
                 *
                 * @author {}
                 * @NApiVersion {}
                 * @NScriptType {}
                 */

            ]],
		{ i(1), getGitUser(), version, type }
	)
end

local snippets = {
	s("mapReduceTag", createNSTag("2.1", "MapReduceScript")),
	s("userEventTag", createNSTag("2.1", "UserEventScript")),
	s("clientScriptTag", createNSTag("2.1", "ClientScript")),
	s("massUpdateScriptTag", createNSTag("2.1", "MassUpdateScript")),
	s("portletTag", createNSTag("2.1", "Portlet")),
	s("restletTag", createNSTag("2.1", "Restlet")),
	s("scheduledScriptTag", createNSTag("2.1", "ScheduledScript")),
	s("suiteletTag", createNSTag("2.1", "Suitelet")),
	s("workflowActionScriptTag", createNSTag("2.1", "WorkflowActionScript")),
}

ls.add_snippets("javascript", snippets)
ls.add_snippets("typescript", snippets)
