//variáveis
texto = "";


//ajustando efeito wave
scribble_anim_wave(1, 0.2, 0.1);

//efeito maquina de escrever
typist = scribble_typist();
typist.in(0.5,5);

desenharTexto = false;
meDestruir = false;

ystart = y;

image_xscale = .1;
image_yscale = .1;

image_alpha = 0;