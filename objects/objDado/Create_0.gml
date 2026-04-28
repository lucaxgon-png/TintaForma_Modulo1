estado = noone;
timer = timerValue;


//contador estado
contadorEstado = function (_estadoDestino)
    {
        timer++;
        
        if (timer >= timerValue)
        {
            timer = 0;
            estado = _estadoDestino;
        }
    }

//maquina de estados
//estado setinha
estadoSetinha = function ()
    {
        //parado na imagem 0
        image_index = 0;
        
        //voltando a ter colissão
        mask_index = sprDado;
        
        //solta o timer e muda de estado
        contadorEstado(estadoTransicao1);
    }
    

//estado transição 1
estadoTransicao1 = function ()
    {
        //chegou na image_index 8, ele vai para o prox estado
        if (image_index >= 8)
        {
            estado = estadoXIS;
        }
    }

//estado XIS
estadoXIS = function ()
    {
        //fica parado no image XIS
        image_index = 8;
        
        //tirando a colissão
        mask_index = sprVazio;
        
        //solta o timer e muda de estado
        contadorEstado(estadoTransicao2);
    }
    

//estado transição 2
estadoTransicao2 = function ()
    {
         if (image_index >= image_number-1 )
        {
            estado = estadoSetinha;
        }
    }

//colocando o estado correto
if (estadoInicial == "estadoXIS") { estado = estadoXIS}  
else if (estadoInicial == "estadoSetinha") { estado = estadoSetinha}
