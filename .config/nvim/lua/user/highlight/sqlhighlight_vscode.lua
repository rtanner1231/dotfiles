local hl = vim.api.nvim_set_hl
local isDark = true

local opts = {
	transparent = false,
	italic_comments = false,
	underline_links = false,
	color_overrides = {},
	group_overrides = {},
	disable_nvimtree_bg = true,
	terminal_colors = true,
}

local c = {
	vscNone = "NONE",
	vscFront = "#D4D4D4",
	vscBack = "#1F1F1F",

	vscTabCurrent = "#1F1F1F",
	vscTabOther = "#2D2D2D",
	vscTabOutside = "#252526",

	vscLeftDark = "#252526",
	vscLeftMid = "#373737",
	vscLeftLight = "#636369",

	vscPopupFront = "#BBBBBB",
	vscPopupBack = "#272727",
	vscPopupHighlightBlue = "#004b72",
	vscPopupHighlightGray = "#343B41",

	vscSplitLight = "#898989",
	vscSplitDark = "#444444",
	vscSplitThumb = "#424242",

	vscCursorDarkDark = "#222222",
	vscCursorDark = "#51504F",
	vscCursorLight = "#AEAFAD",
	vscSelection = "#264F78",
	vscLineNumber = "#5A5A5A",

	vscDiffRedDark = "#4B1818",
	vscDiffRedLight = "#6F1313",
	vscDiffRedLightLight = "#FB0101",
	vscDiffGreenDark = "#373D29",
	vscDiffGreenLight = "#4B5632",
	vscSearchCurrent = "#515c6a",
	vscSearch = "#613315",

	vscGitAdded = "#81b88b",
	vscGitModified = "#e2c08d",
	vscGitDeleted = "#c74e39",
	vscGitRenamed = "#73c991",
	vscGitUntracked = "#73c991",
	vscGitIgnored = "#8c8c8c",
	vscGitStageModified = "#e2c08d",
	vscGitStageDeleted = "#c74e39",
	vscGitConflicting = "#e4676b",
	vscGitSubmodule = "#8db9e2",

	vscContext = "#404040",
	vscContextCurrent = "#707070",

	vscFoldBackground = "#202d39",

	-- Syntax colors
	vscGray = "#808080",
	vscViolet = "#646695",
	vscBlue = "#569CD6",
	vscAccentBlue = "#4FC1FF",
	vscDarkBlue = "#223E55",
	vscMediumBlue = "#18a2fe",
	vscDisabledBlue = "#729DB3",
	vscLightBlue = "#9CDCFE",
	vscGreen = "#6A9955",
	vscBlueGreen = "#4EC9B0",
	vscLightGreen = "#B5CEA8",
	vscRed = "#F44747",
	vscOrange = "#CE9178",
	vscLightRed = "#D16969",
	vscYellowOrange = "#D7BA7D",
	vscYellow = "#DCDCAA",
	vscDarkYellow = "#FFD602",
	vscPink = "#C586C0",

	-- Low contrast with default background
	vscDimHighlight = "#51504F",
}

hl(0, "@error.sql", { fg = c.vscRed, bg = "NONE" }) -- Legacy
hl(0, "@punctuation.bracket.sql", { fg = c.vscFront, bg = "NONE" })
hl(0, "@punctuation.special.sql", { fg = c.vscFront, bg = "NONE" })
hl(0, "@punctuation.delimiter.sql", { fg = c.vscFront, bg = "NONE" })
hl(0, "@comment.sql", { fg = c.vscGreen, bg = "NONE", italic = opts.italic_comments })
hl(0, "@comment.note.sql", { fg = c.vscBlueGreen, bg = "NONE", bold = true })
hl(0, "@comment.warning.sql", { fg = c.vscYellowOrange, bg = "NONE", bold = true })
hl(0, "@comment.error.sql", { fg = c.vscRed, bg = "NONE", bold = true })
hl(0, "@constant.sql", { fg = c.vscAccentBlue, bg = "NONE" })
hl(0, "@constant.builtin.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@constant.macro.sql", { fg = c.vscBlueGreen, bg = "NONE" })
hl(0, "@string.regexp.sql", { fg = c.vscOrange, bg = "NONE" })
hl(0, "@string.sql", { fg = c.vscOrange, bg = "NONE" })
hl(0, "@character.sql", { fg = c.vscOrange, bg = "NONE" })
hl(0, "@number.sql", { fg = c.vscLightGreen, bg = "NONE" })
hl(0, "@number.float.sql", { fg = c.vscLightGreen, bg = "NONE" })
hl(0, "@boolean.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@annotation.sql", { fg = c.vscYellow, bg = "NONE" })
hl(0, "@attribute.sql", { fg = c.vscYellow, bg = "NONE" })
hl(0, "@attribute.builtin.sql", { fg = c.vscBlueGreen, bg = "NONE" })
hl(0, "@module.sql", { fg = c.vscBlueGreen, bg = "NONE" })
hl(0, "@function.sql", { fg = c.vscYellow, bg = "NONE" })
hl(0, "@function.builtin.sql", { fg = c.vscYellow, bg = "NONE" })
hl(0, "@function.macro.sql", { fg = c.vscYellow, bg = "NONE" })
hl(0, "@function.method.sql", { fg = c.vscYellow, bg = "NONE" })
hl(0, "@define.sql", { fg = c.vscPink, bg = "NONE" })
hl(0, "@variable.sql", { fg = c.vscLightBlue, bg = "NONE" })
hl(0, "@variable.builtin.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@variable.parameter.sql", { fg = c.vscLightBlue, bg = "NONE" })
hl(0, "@variable.parameter.reference.sql", { fg = c.vscLightBlue, bg = "NONE" })
hl(0, "@variable.member.sql", { fg = c.vscLightBlue, bg = "NONE" })
hl(0, "@property.sql", { fg = c.vscLightBlue, bg = "NONE" })
hl(0, "@constructor.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@label.sql", { fg = c.vscLightBlue, bg = "NONE" })
hl(0, "@keyword.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@keyword.conditional.sql", { fg = c.vscPink, bg = "NONE" })
hl(0, "@keyword.repeat.sql", { fg = c.vscPink, bg = "NONE" })
hl(0, "@keyword.return.sql", { fg = c.vscPink, bg = "NONE" })
hl(0, "@keyword.exception.sql", { fg = c.vscPink, bg = "NONE" })
hl(0, "@keyword.import.sql", { fg = c.vscPink, bg = "NONE" })
hl(0, "@operator.sql", { fg = c.vscFront, bg = "NONE" })
hl(0, "@type.sql", { fg = c.vscBlueGreen, bg = "NONE" })
hl(0, "@type.qualifier.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@structure.sql", { fg = c.vscLightBlue, bg = "NONE" })
hl(0, "@tag.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@tag.builtin.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@tag.delimiter.sql", { fg = c.vscGray, bg = "NONE" })
hl(0, "@tag.attribute.sql", { fg = c.vscLightBlue, bg = "NONE" })

hl(0, "@text.sql", { fg = c.vscFront, bg = "NONE" }) -- Legacy
hl(0, "@markup.strong.sql", { fg = isDark and c.vscBlue or c.vscViolet, bold = true })
hl(0, "@markup.italic.sql", { fg = c.vscFront, bg = "NONE", italic = true })
hl(0, "@markup.underline.sql", { fg = c.vscYellowOrange, bg = "NONE", underline = true })
hl(0, "@markup.strikethrough.sql", { fg = c.vscFront, bg = "NONE", strikethrough = true })
hl(0, "@markup.heading.sql", { fg = isDark and c.vscBlue or c.vscYellowOrange, bold = true })
hl(0, "@markup.raw.sql", { fg = c.vscFront, bg = "NONE" })
hl(0, "@markup.raw.markdown.sql", { fg = c.vscOrange, bg = "NONE" })
hl(0, "@markup.raw.markdown_inline.sql", { fg = c.vscOrange, bg = "NONE" })
hl(0, "@markup.link.label.sql", { fg = c.vscLightBlue, bg = "NONE", underline = opts.underline_links })
hl(0, "@markup.link.url.sql", { fg = c.vscFront, bg = "NONE", underline = opts.underline_links })
hl(0, "@markup.list.checked.sql", { link = "Todo" })
hl(0, "@markup.list.unchecked.sql", { link = "Todo" })
hl(0, "@textReference.sql", { fg = isDark and c.vscOrange or c.vscYellowOrange })
hl(0, "@stringEscape.sql", { fg = isDark and c.vscOrange or c.vscYellowOrange, bold = true })

hl(0, "@diff.plus.sql", { link = "DiffAdd" })
hl(0, "@diff.minus.sql", { link = "DiffDelete" })
hl(0, "@diff.delta.sql", { link = "DiffChange" })

-- LSP semantic tokens
hl(0, "@type.builtin.sql", { fg = c.vscBlue, bg = "NONE" })
hl(0, "@lsp.typemod.type.defaultLibrary.sql", { link = "@type.builtin.sql" })
hl(0, "@lsp.type.type.sql", { link = "@type.sql" })
hl(0, "@lsp.type.typeParameter.sql", { link = "@type.sql" })
hl(0, "@lsp.type.macro.sql", { link = "@constant.sql" })
hl(0, "@lsp.type.enumMember.sql", { link = "@constant.sql" })
hl(0, "@lsp.typemod.variable.readonly.sql", { link = "@constant.sql" })
hl(0, "@lsp.typemod.property.readonly.sql", { link = "@constant.sql" })
hl(0, "@lsp.typemod.variable.constant.sql", { link = "@constant.sql" })
hl(0, "@lsp.type.member.sql", { link = "@function.sql" })
hl(0, "@lsp.type.keyword.sql", { link = "@keyword.sql" })
hl(0, "@lsp.typemod.keyword.controlFlow.sql", { fg = c.vscPink, bg = "NONE" })
hl(0, "@lsp.type.comment.c.sql", { fg = c.vscDimHighlight, bg = "NONE" })
hl(0, "@lsp.type.comment.cpp.sql", { fg = c.vscDimHighlight, bg = "NONE" })
hl(0, "@event.sql", { link = "Identifier" })
hl(0, "@interface.sql", { link = "Identifier" })
hl(0, "@modifier.sql", { link = "Identifier" })
hl(0, "@regexp.sql", { fg = c.vscRed, bg = "NONE" })
hl(0, "@decorator.sql", { link = "Identifier" })
