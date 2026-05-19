//se estiver seguindo o player
if (seguirPlayer) exit;

//se não estiver seguindo o player

//aumenta o número de chaves do player
global.key+=1
other.chaves+=1;

//me colocando nas chaves do player
other.minhasChaves[other.chaves] = id;

seguirPlayer = true;
alvo = other;

//numero de chaves
numero = global.key;
