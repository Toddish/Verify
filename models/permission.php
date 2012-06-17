<?php

namespace Verify\Models;

class Permission extends \Eloquent
{
	
	public static $accessible = array('name', 'description');

	public function roles()
	{
		return $this->has_many_and_belongs_to('Verify\Models\Role');
	}

}