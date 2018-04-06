#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# base16-tm scheme by marksteve

color00="{{base00_hex_r}}/{{base00_hex_g}}/{{base00_hex_b}}" # Base 00 - Black
color01="{{base08_hex_r}}/{{base08_hex_g}}/{{base08_hex_b}}" # Base 08 - Red
color02="{{base0B_hex_r}}/{{base0B_hex_g}}/{{base0B_hex_b}}" # Base 0B - Green
color03="{{base0A_hex_r}}/{{base0A_hex_g}}/{{base0A_hex_b}}" # Base 0A - Yellow
color04="{{base0D_hex_r}}/{{base0D_hex_g}}/{{base0D_hex_b}}" # Base 0D - Blue
color05="{{base0E_hex_r}}/{{base0E_hex_g}}/{{base0E_hex_b}}" # Base 0E - Magenta
color06="{{base0C_hex_r}}/{{base0C_hex_g}}/{{base0C_hex_b}}" # Base 0C - Cyan
color07="{{base05_hex_r}}/{{base05_hex_g}}/{{base05_hex_b}}" # Base 05 - White
color08="{{base03_hex_r}}/{{base03_hex_g}}/{{base03_hex_b}}" # Base 03 - Bright Black
color09="{{base08_bright_hex_r}}/{{base08_bright_hex_g}}/{{base08_bright_hex_b}}" # Base 08 - Bright Red
color10="{{base0B_bright_hex_r}}/{{base0B_bright_hex_g}}/{{base0B_bright_hex_b}}" # Base 0B - Bright Green
color11="{{base0A_bright_hex_r}}/{{base0A_bright_hex_g}}/{{base0A_bright_hex_b}}" # Base 0A - Bright Yellow
color12="{{base0D_bright_hex_r}}/{{base0D_bright_hex_g}}/{{base0D_bright_hex_b}}" # Base 0D - Bright Blue
color13="{{base0E_bright_hex_r}}/{{base0E_bright_hex_g}}/{{base0E_bright_hex_b}}" # Base 0E - Bright Magenta
color14="{{base0C_bright_hex_r}}/{{base0C_bright_hex_g}}/{{base0C_bright_hex_b}}" # Base 0C - Bright Cyan
color15="{{base07_hex_r}}/{{base07_hex_g}}/{{base07_hex_b}}" # Base 07 - Bright White
color16="{{base09_hex_r}}/{{base09_hex_g}}/{{base09_hex_b}}" # Base 09
color17="{{base0F_hex_r}}/{{base0F_hex_g}}/{{base0F_hex_b}}" # Base 0F
color18="{{base01_hex_r}}/{{base01_hex_g}}/{{base01_hex_b}}" # Base 01
color19="{{base02_hex_r}}/{{base02_hex_g}}/{{base02_hex_b}}" # Base 02
color20="{{base04_hex_r}}/{{base04_hex_g}}/{{base04_hex_b}}" # Base 04
color21="{{base06_hex_r}}/{{base06_hex_g}}/{{base06_hex_b}}" # Base 06
color_foreground="{{base05_hex_r}}/{{base05_hex_g}}/{{base05_hex_b}}" # Base 05
color_background="{{base00_hex_r}}/{{base00_hex_g}}/{{base00_hex_b}}" # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg {{base05}} # foreground
  put_template_custom Ph {{base00}} # background
  put_template_custom Pi {{base05}} # bold color
  put_template_custom Pj {{base02}} # selection color
  put_template_custom Pk {{base05}} # selected text color
  put_template_custom Pl {{base05}} # cursor
  put_template_custom Pm {{base00}} # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
