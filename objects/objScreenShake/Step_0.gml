//screen shake
	//X e Y viewport
	if (shake > 0.1 )
	{
		var _x = random_range( -shake, shake );
		var _y = random_range( -shake, shake );
		
		//X
		view_set_xport(view_current, _x);
		
		//Y
		view_set_yport(view_current, _y);
	} else
	{
		shake = 0;
		
		//restart view
		view_set_xport( view_current, 0 );
		view_set_yport( view_current, 0 );
	}
	
//stop shake
shake = lerp( shake, 0, 0.1 );