<?php

namespace Verify\Models;

class Permission extends EloquentVerifyBase
{

	/**
	 * Accessible
	 *
	 * @var array
	 */
	public static $accessible = array('name', 'description');

	/**
	 * Roles
	 *
	 * @return object
	 */
	public function roles()
	{
		return $this->has_many_and_belongs_to('Verify\Models\Role', $this->prefix.'permission_role');
	}

}