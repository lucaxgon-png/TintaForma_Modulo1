//screenShake
function ScreenShake( _shake = 1 ) 
{
   	if (instance_exists( objScreenShake ) )
   	{
   		with( objScreenShake )
   		{
   			if ( _shake > shake )
   			{
   				//shake value
   				shake = _shake;
   			}
   		}
   	}
}

