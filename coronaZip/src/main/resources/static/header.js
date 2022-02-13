/**
 * 
 */
 
function activeMenu(menuName){ 
	switch(menuName) {
	  case 'home':
		$('#menuHome').addClass('active');
	    break;
	  case 'center':
		$('#menuCenter').addClass('active');
	    break;
	  case 'board':
		$('#menuBoard').addClass('active');
	    break;
	  case 'myPage':
		$('#menuMyPage').addClass('active');
	    break;
	  case 'setMenu':
		$('#setMenu').addClass('active');
	    break;
	  case 'join':
		$('#menuJoin').addClass('active');
	    break;
	}
}