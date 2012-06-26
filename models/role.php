<?php

namespace Verify\Models;

class Role extends EloquentVerifyBase
{
	
	public static $accessible = array('name', 'description', 'level');

	public function users()
	{
		return $this->has_many('Verify\Models\User');
	}

	public function permissions()
	{
		return $this->has_many_and_belongs_to('Verify\Models\Permission', $this->prefix.'permission_role');
	}

}