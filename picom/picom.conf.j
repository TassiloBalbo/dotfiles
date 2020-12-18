# Shadow
shadow = true;
shadow-radius = 20;
shadow-offset-x = -20;
shadow-offset-y = -20;
shadow-opacity = 0.3;
#shadow-ignore-shaped = true;

#shadow-exclude = "(!name = 'rofi' && !class_g = 'Rofi' && !name = 'dunst' && !class_g = 'Dunst' && !class_g *?= 'Polybar')"

shadow-exclude = [
    "class_g *?= 'VirtualBox'",
    "class_g *?= 'Notify-osd'",
    "class_g *?= 'trayer'",
    "class_g *?= 'navigator'",
    "class_g *?= 'Polybar'",
    "class_g = 'boox'",
    "class_g = 'slop'",
    "class_g = 'hacksaw'",
    "window_type *= 'normal' && ! name ~= ''",
    "_GTK_FRAME_EXTENTS@:c",
    "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'",
    #"window_type *= 'menu'",
    #"window_type = 'utility'",
    #"window_type = 'dock'",
    #"window_type = 'dropdown_menu'",
    #"window_type = 'popup_menu'"
];



# Fade
fading = true;
fade-delta = 1;  # 30;
fade-in-step = 0.01;
fade-out-step = 0.01;
no-fading-openclose = false;
#fade-exclude = [ "name *= 'panel'",
#];

# Backend
vsync = false;
backend = "glx";
#glx-no-stencil = true;
#glx-no-rebind-pixmap = true;
#use-damage = true;

# Opacity
inactive-opacity-override = false;
#alpha-step = 0.06;
opacity-rule = [
        "100:class_g *?= 'Termite'",
];

focus-exclude = [
    "class_g *?= 'Cairo-clock'",
    "class_g *?= 'Virtualbox'",
    "class_g *?= 'trayer'",
    "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'",
    "name *?= 'Authy'"
];

#blur-background = true;
#blur-method = "dual_kawase";
#blur-strength = 12;
#blur-background-fixed = true;

#blur-background-exclude = [
#   "window_type != 'dock'",
#];

wintypes:
{
    tooltip = { fade = true; shadow = false; focus = true; };
    menu = { full-shadow = true;};
    popup_menu =  { full-shadow = true;};
    utility =  {full-shadow = true;};
    toolbar = {full-shadow = true;};
    normal = {full-shadow = true;};
    notification = {full-shadow = true;};
    dialog = {full-shadow = true};
    dock = {shadow = false;};
};
