alvo = noone;

//animação
animation = function()
{
    //só rodo se tiver um alvo
    if (alvo == noone) return;
        
    x = alvo.x;
    y = alvo.y - 36;
}

//explosão de particulas
explosao = function ()
{
    var _qtd = irandom_range(20,50);
    repeat (_qtd)
    {
        var _part = instance_create_layer(x - 12, y, "enfeites", objPartPowerUp);	
        
        _part.speed = random_range(3,6);
        _part.direction = random_range(0, 359);
        
        //dando o alvo da particula
        _part.alvo = alvo;
    }
}