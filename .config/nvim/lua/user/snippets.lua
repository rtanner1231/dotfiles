local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
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
	--Script Types
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

local createEntryPoint = function(entryPointMapping)
	local choices = {}
	for k, v in pairs(entryPointMapping) do
		choices[#choices + 1] = t(v.name)
	end

	local findNode = function(name)
		for k, v in pairs(entryPointMapping) do
			if v.name == name then
				return v
			end
		end
		return nil
	end

	local entryPointType = function(ind)
		return f(function(args)
			local name = args[ind][1]
			local node = findNode(name)
			if node then
				return node.entryPoint
			else
				return ""
			end
		end, { ind })
	end

	local argsName = function(ind)
		return f(function(args)
			local name = args[ind][1]
			local node = findNode(name)
			if node then
				return node.argsName
			else
				return ""
			end
		end, { ind })
	end

	return fmt(
		[[
            export const {}:{}=({})=>{{

            }}
        ]],
		{ c(1, choices), entryPointType(1), argsName(1) }
	)
end

local restletEntryPoints = {
	{
		name = "post",
		entryPoint = "EntryPoints.RESTlet.post",
		argsName = "requestBody",
	},
	{
		name = "get",
		entryPoint = "EntryPoints.RESTlet.get",
		argsName = "requestParms",
	},
	{
		name = "put",
		entryPoint = "EntryPoints.RESTlet.put",
		argsName = "requestBody",
	},
	{
		name = "delete",
		entryPoint = "EntryPoints.RESTlet.delete_",
		argsName = "requestParms",
	},
}

local userEventEntryPoints = {
	{
		name = "afterSubmit",
		entryPoint = "EntryPoints.UserEvent.afterSubmit",
		argsName = "context",
	},
	{
		name = "beforeSubmit",
		entryPoint = "EntryPoints.UserEvent.beforeSubmit",
		argsName = "context",
	},
	{
		name = "beforeLoad",
		entryPoint = "EntryPoints.UserEvent.beforeLoad",
		argsName = "context",
	},
}

local clientScriptEntryPoints = {
	{
		name = "pageInit",
		entryPoint = "EntryPoints.Client.pageInit",
		argsName = "context",
	},
	{
		name = "saveRecord",
		entryPoint = "EntryPoints.Client.saveRecord",
		argsName = "context",
	},
	{
		name = "fieldChanged",
		entryPoint = "EntryPoints.Client.fieldChanged",
		argsName = "context",
	},
	{
		name = "lineInit",
		entryPoint = "EntryPoints.Client.lineInit",
		argsName = "context",
	},
	{
		name = "postSourcing",
		entryPoint = "EntryPoints.Client.postSourcing",
		argsName = "context",
	},
	{
		name = "sublistChanged",
		entryPoint = "EntryPoints.Client.sublistChanged",
		argsName = "context",
	},
	{
		name = "validateDelete",
		entryPoint = "EntryPoints.Client.validateDelete",
		argsName = "context",
	},
	{
		name = "validateField",
		entryPoint = "EntryPoints.Client.validateField",
		argsName = "context",
	},
	{
		name = "validateInsert",
		entryPoint = "EntryPoints.Client.validateInsert",
		argsName = "context",
	},
	{
		name = "validateLine",
		entryPoint = "EntryPoints.Client.validateLine",
		argsName = "context",
	},
	{
		name = "localizationContextEnter",
		entryPoint = "EntryPoints.Client.localizationContextEnter",
		argsName = "context",
	},
	{
		name = "localizationContextExit",
		entryPoint = "EntryPoints.Client.localizationContextExit",
		argsName = "context",
	},
}

local scheculedScriptEntryPoints = {
	{
		name = "execute",
		entryPoint = "EntryPoints.Scheduled.execute",
		argsName = "context",
	},
}

local mapReduceEntryPoints = {
	{
		name = "getInputData",
		entryPoint = "EntryPoints.MapReduce.getInputData",
		argsName = "context",
	},
	{
		name = "map",
		entryPoint = "EntryPoints.MapReduce.map",
		argsName = "context",
	},
	{
		name = "reduce",
		entryPoint = "EntryPoints.MapReduce.reduce",
		argsName = "context",
	},
	{
		name = "summarize",
		entryPoint = "EntryPoints.MapReduce.summarize",
		argsName = "context",
	},
}

local portletEntryPoints = {
	{
		name = "render",
		entryPoint = "EntryPoints.Portlet.render",
		argsName = "context",
	},
}

local suiteletEntryPoints = {
	{
		name = "onRequest",
		entryPoint = "EntryPoints.Suitelet.onRequest",
		argsName = "context",
	},
}

local massUpdateEntryPoints = {
	{
		name = "each",
		entryPoint = "EntryPoints.MassUpdate.each",
		argsName = "context",
	},
}

local workflowActionEntryPoints = {
	{
		name = "onAction",
		entryPoint = "EntryPoints.WorkflowAction.onAction",
		argsName = "context",
	},
}

--other
local tsSnippets = {
	s("entryPoints", fmt("import {{EntryPoints}} from 'N/types'", {})),
	s("restletEntry", createEntryPoint(restletEntryPoints)),
	s("userEventEntry", createEntryPoint(userEventEntryPoints)),
	s("clientScriptEntry", createEntryPoint(clientScriptEntryPoints)),
	s("scheduledScriptEntry", createEntryPoint(scheculedScriptEntryPoints)),
	s("mapReduceEntry", createEntryPoint(mapReduceEntryPoints)),
	s("portletEntry", createEntryPoint(portletEntryPoints)),
	s("suiteletEntry", createEntryPoint(suiteletEntryPoints)),
	s("massUpdateEntry", createEntryPoint(massUpdateEntryPoints)),
	s("workflowActionEntry", createEntryPoint(workflowActionEntryPoints)),
}

ls.add_snippets("typescript", tsSnippets)
