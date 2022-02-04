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
	  case 'border':
		$('#menuBorder').addClass('active');
	    break;
	  case 'myPage':
		$('#menuMyPage').addClass('active');
	    break;
	}
}