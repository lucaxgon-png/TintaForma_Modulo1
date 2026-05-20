//sistema de particulas
ps = part_system_create(PsBrilhoTocha);
part_system_position(ps, x, y);

//quando eu me criar. também vou criar a sprite da tocha na camada de decorações
layer_sprite_create("decoracoes", x, y, sprTocha);