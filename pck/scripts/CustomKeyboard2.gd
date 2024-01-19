extends Control

var shift_pressed = false
var uppercase_mode = false

# This is Login Keyboard

onready var label = $Label

signal enter_pressed(text)
signal cancel_pressed

func number_pressed(digit):
	label.text += str(digit)

func character_pressed(chr):
	if shift_pressed:
		if uppercase_mode:
			chr = chr.to_upper()
		else:
			chr = chr.to_lower()
	label.text += chr

# warning-ignore:unused_argument
func _process(delta):
	if shift_pressed:
		if uppercase_mode:
			$q.text = "Q"
			$w.text = "W"
			$e.text = "E"
			$r.text = "R"
			$t.text = "T"
			$y.text = "Y"
			$u.text = "U"
			$i.text = "I"
			$o.text = "O"
			$p.text = "P"
			
			$a.text = "A"
			$s.text = "S"
			$d.text = "D"
			$f.text = "F"
			$g.text = "G"
			$h.text = "H"
			$j.text = "J"
			$k.text = "K"
			$l.text = "L"
			
			$z.text = "Z"
			$x.text = "X"
			$c.text = "C"
			$v.text = "V"
			$b.text = "B"
			$n.text = "N"
			$m.text = "M"
		else:
			$q.text = "q"
			$w.text = "w"
			$e.text = "e"
			$r.text = "r"
			$t.text = "t"
			$y.text = "y"
			$u.text = "u"
			$i.text = "i"
			$o.text = "o"
			$p.text = "p"
			
			$a.text = "a"
			$s.text = "s"
			$d.text = "d"
			$f.text = "f"
			$g.text = "g"
			$h.text = "h"
			$j.text = "j"
			$k.text = "k"
			$l.text = "l"
			
			$z.text = "z"
			$x.text = "x"
			$c.text = "c"
			$v.text = "v"
			$b.text = "b"
			$n.text = "n"
			$m.text = "m"

func _on_No1_pressed():
	number_pressed(1)


func _on_No2_pressed():
	number_pressed(2)


func _on_No3_pressed():
	number_pressed(3)


func _on_No4_pressed():
	number_pressed(4)


func _on_No5_pressed():
	number_pressed(5)


func _on_No6_pressed():
	number_pressed(6)


func _on_No7_pressed():
	number_pressed(7)


func _on_No8_pressed():
	number_pressed(8)


func _on_No9_pressed():
	number_pressed(9)


func _on_No0_pressed():
	number_pressed(0)


func _on_Paste_pressed():
	if OS.has_clipboard():
		var clipboard_text = OS.get_clipboard()
		label.text = clipboard_text


func _on_q_pressed():
	character_pressed("q")


func _on_w_pressed():
	character_pressed("w")


func _on_e_pressed():
	character_pressed("e")


func _on_r_pressed():
	character_pressed("r")


func _on_t_pressed():
	character_pressed("t")


func _on_y_pressed():
	character_pressed("y")


func _on_u_pressed():
	character_pressed("u")


func _on_i_pressed():
	character_pressed("i")


func _on_o_pressed():
	character_pressed("o")


func _on_p_pressed():
	character_pressed("p")


func _on_backspace_pressed():
	if len(label.text) > 0:
		label.text = label.text.substr(0, label.text.length() - 1)


func _on_a_pressed():
	character_pressed("a")

func _on_s_pressed():
	character_pressed("s")


func _on_d_pressed():
	character_pressed("d")


func _on_f_pressed():
	character_pressed("f")


func _on_g_pressed():
	character_pressed("g")


func _on_h_pressed():
	character_pressed("h")


func _on_j_pressed():
	character_pressed("j")


func _on_k_pressed():
	character_pressed("k")


func _on_l_pressed():
	character_pressed("l")


func _on_Enter_pressed():
#	Config.emit_signal("enterPressed")
#	Config.user_text = label.text
#	self.hide()
	emit_signal("enter_pressed", label.text)
	self.hide()


func _on_ShiftLeft_pressed():
	shift_pressed = true
	
	uppercase_mode = not uppercase_mode


func _on_z_pressed():
	character_pressed("z")


func _on_x_pressed():
	character_pressed("x")


func _on_v_pressed():
	character_pressed("v")


func _on_c_pressed():
	character_pressed("c")


func _on_b_pressed():
	character_pressed("b")


func _on_n_pressed():
	character_pressed("n")


func _on_m_pressed():
	character_pressed("m")


func _on_Cancel_pressed():
	self.hide()
	emit_signal("cancel_pressed")
	

func _on_Comma_pressed():
	character_pressed(",")


func _on_Spacebar_pressed():
	character_pressed(" ")


func _on_Fullstop_pressed():
	character_pressed(".")


func _on_ArrowLeft_pressed():
	character_pressed("<")


func _on_ArrowRight_pressed():
	character_pressed(">")


func _on_ArrowButton_pressed():
	emit_signal("enter_pressed", label.text)
	self.hide()
