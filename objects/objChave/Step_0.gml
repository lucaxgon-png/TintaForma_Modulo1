if (abrePorta)
{
    //meu códigoa até abrir a porta
    //existe a porta alvo?
    if (instance_exists(portaAlvo))
    {
        x = lerp(x, portaAlvo.x, 0.1);
        y = lerp(y, portaAlvo.y - portaAlvo.sprite_height/2, 0.1);
    };
    
    //se minha distância da porta for meno que 2, eu abro a porta e me destruo
    var _dist = abs(x - portaAlvo.x)
    if (_dist < 1)
    {
        portaAlvo.estado = "abrindo";
        instance_destroy();
        
        ScreenShake(10);
    };
    
    //para o código
    exit;   
}

if (seguirPlayer && instance_exists(alvo))
{
    var _distX = abs(x - alvo.x);
    var _margemX = (15 * numero) * -alvo.dir;
    
    //seguindo x
    if (_distX != ( _margemX))
    {
        x = lerp (x, alvo.x + (_margemX), 0.05); 
    };

    //seguindo y
    var _sinwave = 7 * sin((current_time / 1000) * 5 + numero);
    y = lerp(y, alvo.y - 24 + _sinwave, 0.05);
}