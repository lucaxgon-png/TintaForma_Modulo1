
//animaçõa
animation();

if(alvo == noone)
{
    alvo = other.id;
    other.pegaPowerUp();
    global.powerUp = true;
    
    explosao();
}


