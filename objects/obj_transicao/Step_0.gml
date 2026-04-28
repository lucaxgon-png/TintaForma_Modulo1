/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//Decidindo se eu posso começar a segunda transição
if (place_meeting(x, y, objPlayer))
{
    comecar_transicao_2 = true;
}

if (comecar_transicao_2)
{
    //Como o player não é persistente, eu vou existir antes dele na segunda room
    //E eu preciso criar a sequence na posição correta na câmera que se posiciona com base no player
    if (instance_exists(objPlayer))
    {
        //durante 1 frame eu vou deixar a tela totalmente escura 
        //porque o player pode estar em outra posição e como este objeto é persistente, ele vai existir
        //Antes do player.
        //Então vou esperar o player ser criado para a camera achar a posição dele
        //E assim a sequencia pode ser criada na posição correta da câmera
        alarm[1] = 1;
    }
}


