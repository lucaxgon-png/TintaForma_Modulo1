//efeito mola
	function mola1() //no create
	{
		//variáveis
		xscale = 1;
		yscale = 1;
	}

	function mola2( _xscale, _yscale) //no create mas em alguma função que tbm está no step
	{
		xscale = _xscale;
		yscale = _yscale;
	}
	
	function retornaMola(_qtd = .1) //no step
	{
		xscale = lerp(xscale, 1, _qtd)
		yscale = lerp(yscale, 1, _qtd)
	}
	
	function drawMola() //no drawn
	{
		draw_sprite_ext(sprite_index, image_index, x, y, xscale, yscale, image_angle, image_blend, image_alpha);
	}
	

