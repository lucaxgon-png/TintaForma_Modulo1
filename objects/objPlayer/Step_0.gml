//inputs
    inputs();

//movimento
    grounCheck();

 //CORRIGINDO DADO //se eu estou dentro do dado, eu removo ele da colissão
    removendoColissaoOneWay();

//roomRestar
    roomRestart();

//power up
    pegaPowerUp();

//correr 
    correr();

//sprite
    var _spd = sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps);
    spriteScale();

//alternando o modo DEBUG
    ativaDebug();

//efeito mola
    retornaMola();

//retornando alphaBrilho a 0
   retornaBrilho();

//abre porta
    abrePorta();

//usando coyote
    coyoteJump();

//buffer
    buffer();

//rodando o meu estado
    estado();

//deixando a tela cheia clicando em f11
if (keyboard_check_pressed(vk_f11))
{   
    //pegando se a tela está cheia
    var _full = window_get_fullscreen();
    
    //alternando cheia/meia
    window_set_fullscreen(!_full);
}

   
