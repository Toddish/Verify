<?php

namespace Verify\Models;

class Permission extends EloquentVerifyBase
{
	
	public static $accessible = array('name', 'description');

	public function roles()
	{
		return $this->has_many_and_belongs_to('Verify\Models\Role', $this->prefix.'permission_role');
	}

}