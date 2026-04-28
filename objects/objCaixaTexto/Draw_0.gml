//me desenhar
draw_self();

if (desenharTexto == false) exit;

/*
//configs
draw_set_font(FontDialogo);
draw_set_halign(0);
draw_set_valign(0);
*/

var _margem = 3;
var _x = x - sprite_width/2 + _margem;
var _y = y - sprite_height/2 + _margem;
var _larg = (sprite_width * 5) -(-_margem * 5);

/*
//desenhar texto
draw_text_ext_transformed(_x, _y, texto, 60, -_larg, 0.2, 0.2, 0);

//reset
draw_set_font(-1);
*/

//draw com scribble
var _txt = scribble(texto).starting_format("FontDialogo", c_white);

//configs
_txt = _txt.scale(0.2);
_txt = _txt.wrap(sprite_width - _margem * 2);

//desenhando o texto
_txt.draw(_x,_y, typist);
