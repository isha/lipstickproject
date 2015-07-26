$(document).on('ready', function() {

	$('.collapsible-header').on('click', function() {
		var sibling_row_one = $(this).next();
		var sibling_row_two = $(this).next().next();
		if(sibling_row_one.hasClass('show')){
			sibling_row_one.removeClass('show');
			sibling_row_two.removeClass('show');
		} else {
			sibling_row_two.addClass('show');
			sibling_row_one.addClass('show');
		}
	})
})