//desenhando brilho
    //variando a escala da tocha
    var _escala = random_range(0,0.03)
    
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprBrilhoTocha, 0, x, y, 0.3 + _escala, 0.3 + _escala, 0, c_white, 0.2);
    
    gpu_set_blendmode(-1);