<?php

namespace Verify\Models;

class User extends EloquentVerifyBase
{

	public static $accessible = array('username', 'password', 'salt', 'email', 'role_id', 'verified', 'deleted', 'disabled');
	public static $cache_can;

	/**
	 * Role
	 *
	 * @return object
	 */
	public function roles()
	{
		return $this->has_many_and_belongs_to('Verify\Models\Role', $this->prefix.'role_user');
	}

	/**
	 * Salts and saves the password
	 *
	 * @param string $password
	 */
	public function set_password($password)
	{
		$salt = md5(\Str::random(64) . time());
		$hashed = \Hash::make($salt . $password);

		$this->set_attribute('password', $hashed);
		$this->set_attribute('salt', $salt);
	}

	/**
	 * Can the User do something
	 *
	 * @param  array|string $permissions Single permission or an array or permissions
	 * @return boolean
	 */
	public function can($permissions)
	{
		$permissions = !is_array($permissions)
			? array($permissions)
			: $permissions;

		$class = get_class();

		if(empty($this->cache_can))
		{
			$to_check = new $class;

			$to_check = $class::with(array('role', 'role.permissions'))
				->where('id', '=', $this->get_attribute('id'))
				->first();

			$this->cache_can = $to_check;
		}
		else
		{
			$to_check = $this->cache_can;
		}

		// Are we a super admin?
		if ($to_check->role->name === \Config::get('verify::verify.super_admin'))
		{
			return TRUE;
		}

		$valid = FALSE;
		foreach ($to_check->role->permissions as $permission)
		{
			if (in_array($permission->name, $permissions))
			{
				$valid = TRUE;
				break;
			}
		}

		return $valid;
	}

	/**
	 * Is the User a Role
	 *
	 * @param  array|string  $roles A single role or an array of roles
	 * @return boolean
	 */
	public function is($roles)
	{
		$roles = !is_array($roles)
			? array($roles)
			: $roles;

		$class = get_class();

		if(empty($this->cache_is))
		{
			$to_check = new $class;

			$to_check = $class::with(array('roles'))
				->where('id', '=', $this->get_attribute('id'))
				->first();

			$this->cache_is = $to_check;
		}
		else
		{
			$to_check = $this->cache_is;
		}

		$valid = FALSE;
		foreach ($to_check->roles as $role)
		{
			if (in_array($role->name, $roles))
			{
				$valid = TRUE;
				break;
			}
		}

		return $valid;
	}

	/**
	 * Is the User a certain Level
	 *
	 * @param  integer $level
	 * @param  string $modifier [description]
	 * @return boolean
	 */
	public function level($level, $modifier = '>=')
	{
		$user_level = $this->role->level;

		switch ($modifier)
		{
			case '=':
				return $user_level == $level;
				break;

			case '>=':
				return $user_level >= $level;
				break;

			case '>':
				return $user_level > $level;
				break;

			case '<=':
				return $user_level <= $level;
				break;

			case '<':
				return $user_level < $level;
				break;

			default:
				return false;
				break;
		}
	}

}
