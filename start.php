<?php

Autoloader::namespaces(array(

	'Verify\Models'	=> Bundle::path('verify').'models'

));

Autoloader::map(array(

	'Verify' 	=> __DIR__ . '/libraries/verify.php'

));

Auth::extend('verify', function() {

	return new Verify;

});