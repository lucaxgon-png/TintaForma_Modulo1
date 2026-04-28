//alterando o alpha com base na velocidade
image_alpha = speed/random_range(6,2);

if(alvo == noone)exit; //só roda se tiver alvo

//eu vou me esticar de acordo com a minha vel
image_xscale = lerp(image_xscale, speed * 3, 0.1);
image_angle = direction;
    
//perdendo vel
    
    if ( voltar == false ) 
    {   speed -= 0.1; 
        if ( speed <= 0 )
        {
            voltar = true;
            
             //direção
             var _x = alvo.x + random_range(-5, 5);
             var _y = alvo.y - 14 + random_range(-5, 5);
             var _dir = point_direction( x, y, _x, _y ); 
             direction = _dir;
        }
    }
     else if ( voltar == true )
    {
        speed += 0.2;  //ganha vel
     
        //colidindo player
        var _player = instance_place(x, y, objPlayer)
            if (_player)
            {
                //efeito de mola
                 with (_player)
                {
                    var _xscale = random_range( -0.1, +0.3)
                    var _yscale = random_range( -0.1, +0.3);
                    mola2( 1 + _xscale, 1 + _yscale); 
                    
                //efeito brilho    
                aplicaBrilho();
                }
            }
        
        //se destruindo
        if (place_meeting( x, y, alvo))
        {
            //screen shake
            ScreenShake(1.5);
            
            instance_destroy();
        }
    }
            
   
    
        