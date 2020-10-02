
class_name ThemeManager

var themes_ext = []
var themes = []
var theme_names = []

static func font_create():
	var _font = DynamicFont.new()
	_font.font_data = load("res://src/Roboto-Bold.ttf")
	_font.size = 24
	return _font

static func styleboxflat_create(_color, _radius, _border):
	var _box = StyleBoxFlat.new()
	_box.bg_color = _color
	_box.corner_radius_bottom_left = _radius
	_box.corner_radius_bottom_right = _radius
	_box.corner_radius_top_left = _radius
	_box.corner_radius_top_right = _radius
	_box.border_color = _color
	_box.border_width_top = _border
	_box.border_width_bottom = _border
	_box.border_width_left = _border
	_box.border_width_right = _border
	_box.border_blend = false
	return _box

static func styleboxline_create(_color, _thickness):
	var _box = StyleBoxFlat.new()
	_box.color = _color
	_box.thickness = _thickness
	return _box

func init():
	
	theme_names.append("Light")
	themes.append(theme_create(Color("#ebebeb"), Color("#fafafa"), Color("#1f1f1f"), Color("#1f1f1f"), Color("#ebebeb"), Color("#1f1f1f"), Color("#c2c2c2"), Color("#a6a6a6")))
	
	theme_names.append("Dark")
	themes.append(theme_create(Color("#4e4e4e"), Color("#676767"), Color("#e6e6e6"), Color("#e6e6e6"), Color("#676767"), Color("#e6e6e6"), Color("#333333"), Color("#1f1f1f")))

	theme_names.append("Sand")
	themes.append(theme_create(Color("#e1dccd"), Color("#f7f4e4"), Color("#5f8e4c"), Color("#5f8e4c"), Color("#f3f3f3"), Color("#808080"), Color("#cdbea7"), Color("#b09d88")))

func theme_create_ext(_background):
	return {
		"background": _background
	}
	
func theme_create(C_BUTTON, C_BUTTON_HOVER, C_BUTTON_FONT, C_LABEL, C_LINE_EDIT, C_LINE_EDIT_FONT, C_PANEL_CONTAINER, C_BACKGROUND):
	var _theme

	# NEW THEME
	_theme = Theme.new()
	_theme.copy_theme(load("res://src/theme_alien.tres"))
	_theme.set_default_font(font_create())
	
	themes_ext.append(theme_create_ext(C_BACKGROUND))
	
	var C_PANEL = C_PANEL_CONTAINER
	var C_OPTION_BUTTON = C_BUTTON
	var C_OPTION_BUTTON_FONT = C_LABEL
	var C_POPUP_MENU = C_OPTION_BUTTON
	var C_POPUP_MENU_FONT = C_LINE_EDIT_FONT
	var C_POPUP_MENU_FONT_HOVER = C_LABEL
	var C_CHECK_BUTTON_FONT = C_LABEL
	
	# BUTTON
	var _box_button = styleboxflat_create(C_BUTTON, 20, 10)
	var _box_button_hover = styleboxflat_create(C_BUTTON_HOVER, 20, 10)
	_theme.set_stylebox("disabled", "Button", _box_button)
	_theme.set_stylebox("focus", "Button", _box_button)
	_theme.set_stylebox("normal", "Button", _box_button)
	_theme.set_stylebox("pressed", "Button", _box_button)
	_theme.set_stylebox("hover", "Button", _box_button_hover)
	_theme.set_color("font_color", "Button", C_BUTTON_FONT)
	_theme.set_color("font_color_disabled", "Button", C_BUTTON_FONT)
	_theme.set_color("font_color_hover", "Button", C_BUTTON_FONT)
	_theme.set_color("font_color_pressed", "Button", C_BUTTON_FONT)
	
	 # LABEL
	_theme.set_color("font_color", "Label", C_LABEL)

	# LINE EDIT
	var _box_line_edit = styleboxflat_create(C_LINE_EDIT, 20, 10)
	_theme.set_stylebox("focus", "LineEdit", _box_line_edit)
	_theme.set_stylebox("normal", "LineEdit", _box_line_edit)
	_theme.set_color("font_color", "LineEdit", C_LINE_EDIT_FONT)
	_theme.set_color("selection_color", "LineEdit", Color(0.2, 0.2, 0.2, 0.5))
	
	# PANEL CONTAINER
	var _box_panel_container = styleboxflat_create(C_PANEL_CONTAINER, 20, 0)
	_theme.set_stylebox("panel", "PanelContainer", _box_panel_container)

	# PANEL
	var _box_panel = styleboxflat_create(C_PANEL, 20, 4)
	_box_panel.border_color = C_BACKGROUND
	_theme.set_stylebox("panel", "Panel", _box_panel)
	
	# OPTION BUTTON
	var _box_option = styleboxflat_create(C_OPTION_BUTTON, 20, 10)
	_theme.set_stylebox("disabled", "OptionButton", _box_option)
	_theme.set_stylebox("focus", "OptionButton", _box_option)
	_theme.set_stylebox("hover", "OptionButton", _box_option)
	_theme.set_stylebox("normal", "OptionButton", _box_option)
	
	_box_option = styleboxflat_create(C_OPTION_BUTTON, 20, 10)
	_box_option.corner_radius_bottom_left = 0
	_box_option.corner_radius_bottom_right = 0
	_theme.set_stylebox("pressed", "OptionButton", _box_option)
	
	_theme.set_color("font_color", "OptionButton", C_OPTION_BUTTON_FONT)
	_theme.set_color("font_color_disabled", "OptionButton", C_OPTION_BUTTON_FONT)
	_theme.set_color("font_color_hover", "OptionButton", C_OPTION_BUTTON_FONT)
	_theme.set_color("font_color_pressed", "OptionButton", C_OPTION_BUTTON_FONT)
	
	# POPUP MENU
	var _box_popup_menu = styleboxflat_create(C_POPUP_MENU, 20, 10)
	_theme.set_stylebox("disabled", "PopupMenu", _box_popup_menu)
	_theme.set_stylebox("focus", "PopupMenu", _box_popup_menu)
	_theme.set_stylebox("hover", "PopupMenu", _box_popup_menu)
	_theme.set_stylebox("normal", "PopupMenu", _box_popup_menu)
	_theme.set_stylebox("pressed", "PopupMenu", _box_popup_menu)
	_box_popup_menu = styleboxflat_create(C_POPUP_MENU, 20, 0)
	_box_popup_menu.corner_radius_top_left = 0
	_box_popup_menu.corner_radius_top_right = 0
	_theme.set_stylebox("panel", "PopupMenu", _box_popup_menu)
	_theme.set_stylebox("panel_disabled", "PopupMenu", _box_popup_menu)
	_theme.set_color("font_color", "PopupMenu", C_POPUP_MENU_FONT)
	_theme.set_color("font_color_accel", "PopupMenu", C_POPUP_MENU_FONT)
	_theme.set_color("font_color_disabled", "PopupMenu", C_POPUP_MENU_FONT)
	_theme.set_color("font_color_hover", "PopupMenu", C_POPUP_MENU_FONT_HOVER)

#	# POPUP DIALOG
#	var _box_popup_dialog = styleboxflat_create(Color.white, 20)
#	_theme.set_stylebox("panel", "PopupDialog", _box_popup_dialog)
	
	# CHECK BUTTON
	var _box_check_button = styleboxflat_create(Color(0, 0, 0, 0), 20, 0)
	_theme.set_stylebox("disabled", "CheckButton", _box_check_button)
	_theme.set_stylebox("focus", "CheckButton", _box_check_button)
	_theme.set_stylebox("hover", "CheckButton", _box_check_button)
	_theme.set_stylebox("hover_pressed", "CheckButton", _box_check_button)
	_theme.set_stylebox("normal", "CheckButton", _box_check_button)
	_theme.set_stylebox("pressed", "CheckButton", _box_check_button)
	_theme.set_color("font_color", "CheckButton", C_CHECK_BUTTON_FONT)
	_theme.set_color("font_color_disabled", "CheckButton", C_CHECK_BUTTON_FONT)
	_theme.set_color("font_color_hover", "CheckButton", C_CHECK_BUTTON_FONT)
	_theme.set_color("font_color_hover_pressed", "CheckButton", C_CHECK_BUTTON_FONT)
	_theme.set_color("font_color_pressed", "CheckButton", C_CHECK_BUTTON_FONT)
	
	# RICH TEXT LABEL
	var _box_rich_text_label = styleboxflat_create(C_PANEL, 20, 20)
	_theme.set_stylebox("normal", "RichTextLabel", _box_rich_text_label)
	_theme.set_stylebox("focus", "RichTextLabel", _box_rich_text_label)
	_theme.set_color("default_color", "RichTextLabel", C_LABEL)
	
	# TEXT EDIT
	var _box_text_edit = styleboxflat_create(C_LINE_EDIT, 20, 20)
	_theme.set_stylebox("normal", "TextEdit", _box_text_edit)
	_theme.set_stylebox("focus", "TextEdit", _box_text_edit)
	_theme.set_color("font_color", "TextEdit", C_LABEL)
	_theme.set_color("font_color_selected", "TextEdit", C_LABEL)
	_theme.set_color("selection_color", "TextEdit", Color(0.2, 0.2, 0.2, 0.5))
	
	return _theme
	
