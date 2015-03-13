// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require social-share-button
//= require_tree .

$(document).ready(function(){
	var data = '{'+
				  '"comment": "Check out developer.linkedin.com!",'+
				  '"content": {'+
				    '"title": "LinkedIn Developers Resources",'+
				    '"description": "Leverage LinkedIns APIs to maximize engagement",'+
				    '"submitted-url": "https://developer.linkedin.com",'+
				    '"submitted-image-url": "https://example.com/logo.png"'+
				  '},'+
				  '"visibility": {'+
				    '"code": "anyone"'+
				  '} '+
				'}';

	$('#share_post_button').click(function(){
		 $.ajax({
			  url: "https://api.linkedin.com/v1/people/~/shares?format=json",
			  data: data
			}).done(function() {
			  alert('done');
		 	});
	});
})