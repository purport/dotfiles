local function hsl(h, s, l)
  return {h,s,l}
end

local function lighten(c, a)
  local h,s,l = unpack(c)
  return {h,s,l+a}
end

local function darken(c, a)
  local h,s,l = unpack(c)
  return {h,s,l-a}
end

local function desaturate(c, a)
  local h,s,l = unpack(c)
  return {h,s-a,l}
end

local function rotate(c, a)
  local h,s,l = unpack(c)
  return {h+a,s,l}
end

local function hsl_to_rgb(h, s, l)
  h = h % 360
  s = math.max(math.min(s/100.0, 1), 0)
  l = math.max(math.min(l/100.0, 1), 0)
  local c = (1-math.abs(2*l-1))*s
  local x = c*(1-math.abs(((h/60.0) % 2)-1))
  local m = l-c/2.0
  local r=0
  local g=0
  local b=0
  if 0 <= h and h < 60 then
    r=c
    g=x
  elseif 60 <= h and h < 120 then
    r=x
    g=c
  elseif 120 <= h and h < 180 then
    g=c
    b=x
  elseif 180 <= h and h < 240 then
    g=x
    b=c
  elseif 240 <= h and h < 300 then
    r=x
    b=c
  elseif 300 <= h and h < 360 then
    r=c
    b=x
  end
  return {r+m,g+m,b+m}
end

local function hex(c)
  local r,g,b=unpack(hsl_to_rgb(unpack(c)))
  return '#'..string.format("%02x", r*255)..string.format("%02x", g*255)..string.format("%02x", b*255)
end

local function set_highlight_vivid_calls_on_line(buf, line, line_num)

  local function hsl_h_s_l_call_to_color(hsl_hsl_str)
    local h, s, l = string.match(hsl_hsl_str,"hsl%("..re_h_s_l_args_pat.."%)")
    return hsl(tonumber(h), tonumber(s), tonumber(l))
  end
  local re_h_s_l_args_pat = "%s-(%d+)%s-,%s-(%d+)%s-,%s-(%d+)%s-"
  local re_hsl_h_s_l_call_pat = "hsl%("..re_h_s_l_args_pat.."%)"

end

local light_pink    = hsl(0, 100, 84);
local deep_champagne= hsl(33, 100, 82);
local lemon_yellow  = hsl(62, 100, 86);
local tea_green     = hsl(138, 30, 55);
local electric_blue = hsl(185, 100, 80);
local baby_blue     = hsl(217, 100, 81);
local blue_purple   = hsl(249, 100, 85);
local mauve         = hsl(300, 100, 89);
local baby_powder   = hsl(60, 100, 99);

local fg = baby_powder
local bg = darken(desaturate(baby_blue, 73), 64);

local colorscheme = {
  Normal = {fg, bg},
  NormalFloat = {link='Normal'},
  Visual = {bg=lighten(bg, 20)},
  Cursor = {reverse=true},
  LineNr = {lighten(bg,20)},
  CursorLine = {},
  CursorLineNr = {rotate(lighten(bg,30),40)},
  EndOfBuffer = {bg},
  SignColumn = {},
  VertSplit = {lighten(bg,10)},
  NonText={link='Normal'},
  Pmenu={link='Normal'},
  Title={fg, bg, bold=true},

  Constant      = {electric_blue},
  String        = {link='Constant'},
  Character     = {link='Constant'},
  Number        = {link='Constant'},
  Boolean       = {link='Constant'},

  Statement     = {baby_blue},
  Conditional   = {link='Statement'},
  Repeat        = {link='Statement'},
  Label         = {link='Statement'},
  Operator      = {link='Statement'},
  Keyword       = {blue_purple},
  Exception     = {link='Statement'},

  Identifier    = {baby_blue},
  Function      = {link='Identifier'},
  ['@function.call'] = {link='Identifier'},

  PreProc       = {desaturate(darken(lemon_yellow, 10), 40)},
  Include       = {link='PreProc'},
  Define        = {link='PreProc'},
  Macro         = {link='PreProc'},
  PreCondit     = {link='PreProc'},

  Type          = {mauve},
  StorageClass  = {desaturate(darken(mauve, 20), 80)},
  Structure     = {link='Type'},
  Typedef       = {link='Type'},

  Special       = {desaturate(darken(baby_blue, 20), 80)},
  SpecialChar   = {link='Special'},
  Tag           = {link='Special'},
  Delimiter     = {link='Special'},
  SpecialComment= {link='Special'},
  Debug         = {link='Special'},

  Comment       = {lighten(bg, 40)},

  TSConstructor = {baby_blue},
  ['@constructor'] = {baby_blue},
  TSOperator    = {lemon_yellow},
  ['@operator'] = {lemon_yellow},
  TSVariableBuiltin = {tea_green},
  ['@variable.builtin'] = {tea_green},
  TSConstantBuiltin = {tea_green},
  ['@constant.builtin'] = {tea_green},
  TSKeywordReturn = {lighten(light_pink, 3)},
  ['@keyword.return'] = {lighten(light_pink, 3)},
  TSParameter = {link='Normal'},
  ['@parameter'] = {link='Normal'},
  TSVariable = {link='Normal'},
  ['@variable'] = {link='Normal'},
  TSField = {link='Normal'},
  ['@field'] = {link='Normal'},
}

local colors = {
  light_pink     = hex(light_pink),
  deep_champagne = hex(deep_champagne),
  lemon_yellow   = hex(lemon_yellow),
  tea_green      = hex(tea_green),
  electric_blue  = hex(electric_blue),
  baby_blue      = hex(baby_blue),
  blue_purple    = hex(blue_purple),
  mauve          = hex(mauve),
  baby_powder    = hex(baby_powder),
}

local lualine = {
  normal={
    a={bg=hex(darken(desaturate(mauve, 75), 65))},
    b={bg=hex(rotate(darken(desaturate(mauve, 80), 60),-55))},
    c={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    x={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    y={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    z={bg=hex(darken(desaturate(baby_blue, 73), 64))},
  },
  insert={
    a={bg=hex(darken(desaturate(baby_blue, 60), 45))},
    b={bg=hex(darken(desaturate(baby_blue, 80), 55))},
    c={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    x={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    y={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    z={bg=hex(darken(desaturate(baby_blue, 73), 64))},
  },
  command={
    a={bg=hex(darken(desaturate(electric_blue, 60), 45))},
    b={bg=hex(darken(desaturate(electric_blue, 80), 55))},
    c={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    x={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    y={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    z={bg=hex(darken(desaturate(baby_blue, 73), 64))},
  },
  visual={
    a={bg=hex(darken(desaturate(lemon_yellow, 60), 48))},
    b={bg=hex(darken(desaturate(lemon_yellow, 80), 58))},
    c={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    x={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    y={bg=hex(darken(desaturate(baby_blue, 73), 64))},
    z={bg=hex(darken(desaturate(baby_blue, 73), 64))},
  }
}

for group, hl in pairs(colorscheme) do
  local t = {}
  if hl[1] then
    t.fg=hex(hl[1])
  end
  if hl[2] then
    t.bg=hex(hl[2])
  elseif hl.bg then
    t.bg=hex(hl.bg)
  end
  if hl.reverse then t.reverse = hl.reverse end
  if hl.link then t.link = hl.link end
  if hl.bold then t.bold = hl.bold end
  -- t.link = ''
  vim.api.nvim_set_hl(0, group, t)
end

local Theme = {}
Theme.colors = colors
Theme.lualine = lualine
Theme.setup = function()


  return Theme
end

return Theme
