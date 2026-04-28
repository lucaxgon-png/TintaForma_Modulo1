// checando colisão com player
var _player = place_meeting(x, y, objPlayer);

// se colidiu
if (_player)
{
    if (dialogo == noone)
    { 
        // cria caixa de dialogo
        dialogo = instance_create_layer(x, y, "placas", objCaixaTexto);
        
        // passa o texto específico
        dialogo.texto = textoPlaca; 
    }
}
else
{
    // se não está colidindo
    if (instance_exists(dialogo))
    {
        dialogo.meDestruir = true;
        dialogo = noone;
    }
}