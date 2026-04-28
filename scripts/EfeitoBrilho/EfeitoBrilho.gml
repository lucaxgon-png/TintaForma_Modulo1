

//iniciar o efeito do brilho
//você usa essa função para iniciar as variáveis necessárias para o efeito.
//Usa no create.
function iniciaEfeitoBrilho ()
{
    xscale     = 1;
    yscale     = 1;
    dir        = 0;
    
    corBrilho       = c_white;
    alphaBrilho     = 0;
};

//aplica efeito
//você usa essa função pra fazer ele brilhar. No step.
//use onnde/quando você quer que o player brilhe
function aplicaBrilho(_cor = c_white, _alpha = 0.5)
{
    alphaBrilho = _alpha;
    corBrilho = _cor;
};

//retorna alpha brilho
//usa no step pra ele deixar de brilhar
function retornaBrilho(_vel = 0.1)
{
    alphaBrilho= lerp(alphaBrilho, 0, _vel)
};

//desenhando o efeito
//adicione no draw
function desenhaBrilho ()
{
    //só preciso me desenhar se o alphaBrilho for maior que zero
    //se for menor, saio da função
    if (alphaBrilho <= 0.01) return;
    
    shader_set(ShMudaCor);
    draw_sprite_ext(sprite_index, image_index, x, y, xscale * dir, yscale, image_angle, corBrilho, alphaBrilho);
    shader_reset(); 
};