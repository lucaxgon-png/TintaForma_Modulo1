//fazendo ele esticar
image_xscale = lerp(image_xscale, 2.5, .1)
image_yscale = lerp(image_yscale, 1, .1)

//fazendo ele subir um pouquinho
y = lerp( ystart, -37, 0.2 )

//transp
image_alpha = lerp(image_alpha, 1, 0.2);

if ( y <= ystart - 34 ) { desenharTexto = true;}

//me destuir
if (meDestruir)
{
    //animação
    image_xscale = lerp(image_xscale, 0, .2);
    image_yscale = lerp( image_yscale, 0, .2);
    
    //ficando invisivel
    image_alpha = lerp( image_alpha, 0, .2);
    
    //fazendo ele voltar pra baixo
    y = lerp(y, ystart, .2);
    
    //paro de desenhar texto
    desenharTexto = false;
    
    //se eu sumi completamente, me destruo
    if (image_alpha <= 0.5)
    {
        instance_destroy();
    }
    
    typist.reset();
}