local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
	-- 兼容emacs的一些配置
	["n,i|<C-x>0"] = map_cmd("<ESC><C-w>c"):with_noremap(),
	["n,i|<C-x>1"] = map_cmd("<ESC><C-w>o"):with_noremap(),
	["n,i|<C-x>2"] = map_cmd("<ESC>:vsp<CR>"):with_noremap(),
	["n,i|<C-x>3"] = map_cmd("<ESC>:sp<CR>"):with_noremap(),
	["n,i|<C-x>o"] = map_cmd("<ESC><C-w>w"):with_noremap(),
	["n,i|<A-x>"] = map_cmd("<ESC>:"):with_noremap(),
	["n|<A-f>"] = map_cmd("<ESC>w"):with_noremap(),
	["i|<A-f>"] = map_cmd("<ESC>lwi"):with_noremap(),
	["n|<A-b>"] = map_cmd("<ESC>b"):with_noremap(),
	["i|<A-b>"] = map_cmd("<ESC>bi"):with_noremap(),
	["n|<A-BS>"] = map_cmd("db"):with_noremap(),
	["i|<A-BS>"] = map_cmd("<C-w>"):with_noremap(),
	-- ["i,v,x,n|<C-f>"] = map_cmd("<Right>"):with_noremap(),
	-- ["i,v,x,n|<C-b>"] = map_cmd("<Left>"):with_noremap(),
	["x,o,i|<A-u>"] = map_cmd("<ESC>lvwUwi"):with_noremap():with_silent(),
	["n|<A-u>"] = map_cmd("<ESC>vwUw"):with_noremap():with_silent(),
	["x,i,o|<A-d>"] = map_cmd("<ESC>ldwi"):with_noremap():with_silent(),
	["n|<A-d>"] = map_cmd("dw"):with_noremap():with_silent(),
	["x,i,o|<A-l>"] = map_cmd("<ESC>lvwuwi"):with_noremap():with_silent(),
	["n|<A-l>"] = map_cmd("<ESC>vwuw"):with_noremap():with_silent(),
	["v,x,i,n|<C-x>`"] = map_cr("cn"):with_noremap():with_silent(),
	["v,x,i,n|<C-x>p"] = map_cr("cp"):with_noremap():with_silent(),
	["n|<Leader>`"] = map_cr("tabNext"):with_noremap():with_silent(),
	-- Vim map
	--["n|<F3>"] = map_cr("set hls!"):with_noremap():with_silent(),
	["n|<F3>"] = map_cmd("<ESC>q1"):with_noremap():with_silent(),
	["n|<F4>"] = map_cmd("<ESC>@1"):with_noremap():with_silent(),
	["n|<C-x>k"] = map_cr("Bwipeout"):with_noremap():with_silent(),
	["n|<C-s>"] = map_cu("write"):with_noremap(),
	["n|Y"] = map_cmd("y$"),
	["n|D"] = map_cmd("d$"),
	["n|n"] = map_cmd("nzzzv"):with_noremap(), -- 搜索时把当前结果置于屏幕中央并打开折叠
	["n|N"] = map_cmd("Nzzzv"):with_noremap(), -- 搜索时把当前结果置于屏幕中央并打开折叠
	["n|J"] = map_cmd("mzJ`z"):with_noremap(),
	["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
	["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
	["n|<C-j>"] = map_cmd("<C-w>j"):with_noremap(),
	["n|<C-k>"] = map_cmd("<C-w>k"):with_noremap(),
	["n|<C-a>"] = map_cmd("^"):with_noremap(),
	["n|<C-e>"] = map_cmd("<End>"):with_noremap(),
	["n|<A-[>"] = map_cr("vertical resize +5"):with_silent(),
	["n|<A-]>"] = map_cr("vertical resize -5"):with_silent(),
	["n|<A-;>"] = map_cr("resize -2"):with_silent(),
	["n|<A-'>"] = map_cr("resize +2"):with_silent(),
	["n|<C-q>"] = map_cmd(":wqall<CR>"),
	["n|<A-q>"] = map_cmd(":bw<CR>"),
	["n|<A-S-q>"] = map_cmd(":bw!<CR>"),
	["n|<A-s>"] = map_cmd("<Esc>:w<CR>"),
	["n|<leader>o"] = map_cr("setlocal spell! spelllang=en_us"),
	-- Insert
	["i|<F3>"] = map_cmd("<ESC>qa"):with_noremap():with_silent(),
	["i|<C-u>"] = map_cmd("<C-G>u<C-U>"):with_noremap(),
	["i|<C-a>"] = map_cmd("<ESC>^i"):with_noremap(),
	["i|<C-e>"] = map_cmd("<ESC>$i"):with_noremap(),
	["i|<C-s>"] = map_cmd("<Esc>:w<CR>"),
	["i|<A-s>"] = map_cmd("<Esc>:w<CR>"),
	["i|<C-q>"] = map_cmd("<Esc>:wq<CR>"),
	-- command line
	["c|<C-b>"] = map_cmd("<Left>"):with_noremap(),
	["c|<C-f>"] = map_cmd("<Right>"):with_noremap(),
	["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
	["c|<C-e>"] = map_cmd("<End>"):with_noremap(),
	["c|<C-d>"] = map_cmd("<Del>"):with_noremap(),
	["c|<C-h>"] = map_cmd("<BS>"):with_noremap(),
	["c|<C-t>"] = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
	["c|w!!"] = map_cmd("execute 'silent! write !sudo tee % >/dev/null' <bar> edit!"),
	-- Visual
	["v|J"] = map_cmd(":m '>+1<cr>gv=gv"),
	["v|K"] = map_cmd(":m '<-2<cr>gv=gv"),
	["v|<"] = map_cmd("<gv"),
	["v|>"] = map_cmd(">gv"),
}

bind.nvim_load_mapping(def_map)
