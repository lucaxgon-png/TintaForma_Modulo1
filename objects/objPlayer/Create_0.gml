//iniciado coisas
mola1() //inicia efeito mola
iniciaEfeitoBrilho(); //inicia efeito brilho


#region variáveis

//variáveis de movimento
    velh        = 0;
    maxVelh     = 1;
    velV        = 0;
    maxVelV     = 5;
    grav        = 0.3;
    dir         = 1;

//lista de sprites por estado
listaSprites = [sprPlayerParando, sprPlayerIdle];
indiceSprite = 0;

//variáveis de level
    ground = false;
    groundTinta = false;
    
    tilesetTinta = layer_tilemap_get_id("TLTinta");
    var _layer = layer_tilemap_get_id("TlLevel")
    colisoes = [objWall, _layer, objPorta]; //lista de objetos com colissão

//variáveis de inputs
    right   = false;
    left    = false;
    jump    = false;
    paint  = false;
    
//variáveis dos estados
    estado = noone;    


#endregion


#region metódos

    //inputs
        inputs = function()
            {
                
                left = keyboard_check(vk_left) or keyboard_check(ord("A"));
                right = keyboard_check(vk_right) or keyboard_check(ord("D"));
                jump = keyboard_check_pressed(vk_space);
                paint = keyboard_check_pressed(vk_shift);
                
            } 

    //movimento
        movimento = function()
            { 
                //checando se eu estou no chão
                grounCheck();
                
                //moviment
                velh = (right - left) *  maxVelh;
                
                // bloqueio de tinta//caso esteja no TintaLoop, não permite andar fora do tile de tina
                if (estado == estadoTintaLoop)
                {
                   var _dir = sign(velh);

                     if (_dir != 0)
                     {
                         var check_x = (_dir > 0) ? bbox_right + 1 : bbox_left - 1;
                         
                         var tile = tilemap_get_at_pixel(tilesetTinta, check_x, y + 1);
                         
                         if (tile == 0)
                         {
                             velh = 0;
                         }
                     }
                }
                
                //gravidade
                if (!ground) 
                    { 
                        velV += grav; 
                    } else 
                    { 
                        velV = 0; 
                        
                        //arredondando posição Y
                        y = round(y);
                        
                        //pulo
                        if (jump)
                        {
                           velV = - maxVelV;  
                        }
                    }
                
                //limitando a velocidade vertical
                velV = clamp(velV, - maxVelV, maxVelV)
                
                //aplicando o mov horizontal
                move_and_collide(velh, 0, colisoes, 24);
                
                //mov vertical
                move_and_collide(0, velV, colisoes, 24);
                
            }

    //CORRIGINDO DADO //se eu estou dentro do dado, eu removo ele da colissão
        removendoColissaoOneWay = function()
        {
            //checando se eu estou colidiindo
            if (instance_place(x, y, objWallOneWay))
            {
                //checar se ele está na lista de colisão
                if (array_contains(colisoes, objWallOneWay))
                {
                    //remover ele
                    var _ind = array_get_index(colisoes, objWallOneWay)
                    array_delete(colisoes,_ind,1);
                }
            }
        }

   //roomRestart
       roomRestart = function () 
       {
           if (place_meeting(x, y, objEndOfRoom))
               {
                   cria_transicao_inicia(room);
               }
       }
        
    //ground
        grounCheck = function() 
            {
                ground = place_meeting(x, y + 1, colisoes);
                
                //checando se tem tinta
                groundTinta = place_meeting(x, y + 1, tilesetTinta);
            }

    //abre porta
    abrePorta = function ()
    {
        var _porta = instance_place( x + velh, y, objPorta)
        
        if (_porta)
        {
            if (global.key > 0 && _porta.estado == "fechada")
            {
                _porta.estado = "abrindo";
                global.key-=1;
            }
        }
    }

#region sprite control

//função ajuste direção
spriteScale = function()
{ 
    if (velh != 0) dir = sign(velh);
}

//função trocar sprite
trocaSprite = function(_sprite = sprWall) 
{
    //checando sprite correta
    if ( sprite_index != _sprite)
        {
            //troco a sprite
            sprite_index = _sprite;
            //zero a animação
            image_index = 0;
        }
}

//metódo pega power up
pegaPowerUp = function()
{
    if (place_meeting(x, y, objPowerUp))
    {
        estado = estadoPowerUpInicio;
        
    }
    
}
//metódo checa se animação acabou
animacaoAcabou = function()
    {
        //checando se a animação acabou
        var _spd = sprite_get_speed(sprite_index) / FPS;
        if (image_index + _spd >= image_number)
           {
               return true;
           }
    }

//metódo para transição de sprites
    transicaoSprites = function()
    {
         trocaSprite(listaSprites[indiceSprite]);
                
                //checando se acabou a animação da sprite atual
                if (animacaoAcabou())
                {
                    //checando se o array ainda tem mais sprites
                    var _qtd = array_length(listaSprites) - 1;
                    if (indiceSprite < _qtd)
                    {
                        indiceSprite++;
                    }
                }
    }

    trocaEstado = function( _estado = estadoParado, _listaSprite = [sprPlayerIdle]) 
    {
        estado = _estado;
        indiceSprite = 0;
        listaSprites = _listaSprite;
    }

    //estados
        estadoParado = function()
            { 
                //aplica velociade
                movimento();
                
                //troca sprite
                transicaoSprites();
                
                //mudando para o estado movendo
                if (right != left)
                    {
                        trocaEstado(estadoMovendo, [sprPlayerIdleParaCorrer, sprPlayerMove]);
                    }
                
                if (paint)
                {
                    if (global.powerUp == true && groundTinta)
                    {
                     estado = estadoEntrandoNaTinta;   
                    }
                }
                
                //mudando para o estado de pulo
                if (jump)
                    {
                        trocaEstado(estadoPulo, [sprPlayerJumpInicia, sprPlayerPulo])
                        
                        //particula
                         instance_create_depth( x, y, depth -1, objPuloParticulas);
                        
                        //mola efeito
                        mola2(.4,1.8);
                    }
                
                //se eu não estiver tocando no chão, eu estou no estado de pulo
                if (!ground)
                {
                    estado = estadoPulo;
                }
            }
        
        estadoMovendo = function()
            {
                //permitindo o movimento
                movimento();
                
                //troca sprite
                transicaoSprites();
                
                //voltando para o estado parado
                if (velh == 0)
                    {
                        trocaEstado( estadoParado, [sprPlayerParando, sprPlayerIdle]);
                    }
                
                 if (paint && groundTinta)
                {
                    estado = estadoEntrandoNaTinta;
                }
                
                //pulo
                if (jump)
                {
                    trocaEstado(estadoPulo, [sprPlayerJumpInicia, sprPlayerPulo]);
                    
                    //particula
                    instance_create_depth( x, y, depth -1, objPuloParticulas)
                }
                
                if (!ground)
                {
                    estado = estadoPulo;
                }
            }
        
        estadoPulo = function()
            {
                //permitindo o movimento
                movimento();
                
                //se eu bater na parede subindo, eu zero a minha velV
                var _layer = layer_tilemap_get_id("TlLevel");
                var _colisoes = [objWall, _layer];
                if (place_meeting(x,y + sign(velV), _colisoes))
                {
                    velV = 0;
                }
                
                //se eu estou subindo
                if (velV < 0 )
                {
                    transicaoSprites();
                    
                    if (array_contains(colisoes, objWallOneWay)) //parede one way
                    {
                        var _ind = array_get_index(colisoes, objWallOneWay);
                        array_delete(colisoes, _ind, 1)
                    }
                } 
                 else if (velV > 0) //se eu estou descendo
                {
                    //trocando a lista de sprites
                    listaSprites = [sprPlayerQuedaInicio, sprPlayerPuloBaixo]
                    transicaoSprites();
                    
                    if(!place_meeting(x,y,objWallOneWay)) //parede one way
                    {
                        if(!array_contains(colisoes,objWallOneWay)) 
                        {
                            array_push(colisoes, objWallOneWay);
                        }
                    }
                }
                    
                //voltando para parado 
                if (ground)
                {
                    trocaEstado(estadoParado, [sprPlayerPousando, sprPlayerIdle]);
                    
                    //acabei de pousar
                    instance_create_depth(x, y, depth -1 , objPousoParticulas);
                    
                    //efeito mola
                    mola2(1.5,0.5);
                }
            }

        estadoPowerUpInicio = function()
            {
                trocaSprite(sprPlayerPowerUpInicio);
                
                velh = 0;
                velV = 0;
                
                //indo para a prox animação
                if (animacaoAcabou())
                {
                    estado = estadoPowerUpMeio;
                }
            }

        estadoPowerUpMeio = function()
            {
                trocaSprite(sprPlayerPowerUpMeio);
                
                //indo para a prox animação
                if (!instance_exists(objPartPowerUp))
                {
                    estado = estadoPowerUpFinal;
                }
            }

        estadoPowerUpFinal = function()
            {
                trocaSprite(sprPlayerPowerUpFinal);
                
                 //indo para a prox animação
                if (animacaoAcabou())
                {
                    trocaEstado(estadoParado, [sprPlayerIdle]);
                }
            }
            
        estadoEntrandoNaTinta = function()
            {
                //bloqueando movimento enquanto entra
                velh =0;
                
                trocaSprite(sprPlayerTintaEntrar);
                
                //se minha particula não existe, eu crio ela
                if (!instance_exists(objPartTintaEntrar))
                    {
                        instance_create_depth(x, y, depth -1, objPartTintaEntrar);
                    }
                
                //indo para a prox animação
                if (animacaoAcabou())
                {
                    trocaEstado(estadoTintaLoop,[sprPlayerTintaInicio, sprTintaLoop]);
                }
            }

        estadoTintaLoop = function()
        {
            
            //troca sprite
            transicaoSprites();
            
            //máscara de colissão menor
            mask_index = sprTintaLoop;
            
            //permite movimento
            movimento();
            velV = 0;
            
            //parando se não tiver chão
           var _no_chao = place_meeting(x, y + 1, tilesetTinta);

            if (!_no_chao)
            {
                velh = 0;
            }
            
            if (paint)
            {
                //part tinta
                instance_create_depth(x, y, depth-1,objPartTintaSair);
                
                trocaEstado(estadoSaindoDaTinta, [sprPlayerTintaFim, sprPlayerTintaSair]);
                
                //máscara de colissão menor
                mask_index = sprPlayerIdle;
            }
            
        }        

        estadoSaindoDaTinta = function()
            {
                //bloquenado movimento enquanto sai
                velh=0;
                
                //mascara de colisão padrão
                mask_index = sprPlayerIdle
                
                //indo para a prox animação
                var _qtd = array_length(listaSprites) - 1;
                if (animacaoAcabou() && indiceSprite >= _qtd)
                {
                    trocaEstado(estadoParado, [sprPlayerIdle]);
                }
                
                transicaoSprites();
            }

#endregion

    //debug
        viewPlayer = false;

        debug = function()
            {
                //debug
                 show_debug_overlay(1);
                
                //janelinha pra mostrar o debug
                viewPlayer = dbg_view("view player", 1, 40, 60, 250, 300);
                
                 if (global.debug)
                    { 
                        dbg_watch(ref_create(id, "velV"), "velV");      // velocidade V
                        dbg_watch(ref_create(id, "grav"), "grav");      //gravidade
                    
                        //podendo mudar o valor
                        dbg_slider(ref_create(id, "maxVelV"), 0, 10, "maxVelV", 0.1);     // velocidade V
                        dbg_slider(ref_create(id, "grav"),0, 1, "grav", 0.1);             //gravidade
                    }
            }

        ativaDebug = function()
        {
            //alternando o modo DEBUG
            if (keyboard_check_pressed(vk_tab))
              {
                if (!DEBUGMODE) return
                    
                  global.debug = !global.debug;
                
                  //se o jogo está no modo debug, roda debug
                  if (global.debug)
                    {
                       debug(); 
                    } else
                    {       
                        //desativa debug overlay
                        show_debug_overlay(0);
                        //se a minha view existe, e eu não estou no modo debug, eu deleto a view
                        if (dbg_view_exists(viewPlayer))
                        {
                            dbg_view_delete(viewPlayer);
                        }
                    }
              }
        }

#endregion


//As últimas coisas que eu faço no meu create
//definindo estado inicial do player
estado = estadoParado;
