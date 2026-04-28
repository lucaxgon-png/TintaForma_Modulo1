//estado inicial
    estado = "fechada";

//variáveis
    startY = y;

    //PsPorta   PARTICULA
        ps = part_system_create();
        part_system_draw_order(ps, true);
        
        //Emitter
        ptype1 = part_type_create();
        part_type_shape(ptype1, pt_shape_explosion);
        part_type_size(ptype1, 1, 1, 0, 0);
        part_type_scale(ptype1, 0.1, 0.1);
        part_type_speed(ptype1, 0.1, 0.2, 0.01, 0);
        part_type_direction(ptype1, 188, 352, 0, 0);
        part_type_gravity(ptype1, 0, 270);
        part_type_orientation(ptype1, 0, 0, 0, 0, false);
        part_type_colour3(ptype1, $FFFFFF, $7F7F7F, $191919);
        part_type_alpha3(ptype1, 1, 1, 0.141);
        part_type_blend(ptype1, false);
        part_type_life(ptype1, 30, 40);
    
    maquinaEstados = function ()
    {
        switch (estado) 
        {
            case "fechada" :
            {
                //aqui não faz nada
            } break;
                
            case "abrindo" :
            {
                //sistemas de part
                var _x = x + random_range(-sprite_width/1.5, sprite_width/1.5)
                part_particles_create(ps, _x, ystart - sprite_height, ptype1, 1);
                
                //abrindo
                vspeed = -0.5;
                
                //tremendo a tela
                ScreenShake(3);
                x = xstart + random_range(-1, 1);
                
                //checando se já abri
                if ( y < ystart - 38 )
                {
                    estado = "aberta";
                    
                    //rodar alarme
                    alarm[0] = FPS;
                }
                      
            }break;
            	
            case "aberta" :
            {
                //volto para a posição inicial X
                x = xstart;
                
            }break;
        }
    }