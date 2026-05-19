
//animaçõa
animation();

if(alvo == noone)
{
    alvo = other.id;
    other.pegaPowerUp();
    global.powerUpTinta = true;
    
    explosao();
}


