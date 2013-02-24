<?php

namespace Verify\Models;

class Role extends EloquentVerifyBase
{

	/**
	 * Accessible
	 *
	 * @var array
	 */
	public static $accessible = array('name', 'description', 'level');

	/**
	 * Users
	 *
	 * @return object
	 */
	public function users()
	{
		return $this->has_many_and_belongs_to('Verify\Models\User', $this->prefix.'role_user');
	}

	/**
	 * Permissions
	 *
	 * @return object
	 */
	public function permissions()
	{
		return $this->has_many_and_belongs_to('Verify\Models\Permission', $this->prefix.'permission_role');
	}

}