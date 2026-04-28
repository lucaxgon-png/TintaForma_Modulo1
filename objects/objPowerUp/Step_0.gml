//se eu tenho um alvo, vou começar a ficar transparente até sumir
if(alvo)
{
    image_alpha-= 0.01;
    
    if (image_alpha <= 0)
    {
        instance_destroy();
    }
}
    