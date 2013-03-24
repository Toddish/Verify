<?php

namespace Verify\Models;

class User extends EloquentVerifyBase
{

	/**
	 * Accessible
	 *
	 * @var array
	 */
	public static $accessible = array('username', 'password', 'salt', 'email', 'role_id', 'verified', 'deleted', 'disabled');

	/**
	 * To check cache
	 *
	 * @var object
	 */
	public static $to_check_cache;

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

		$to_check = $this->get_to_check();

		// Are we a super admin?
		foreach ($to_check->roles as $role)
		{
			if ($role->name === \Config::get('verify::verify.super_admin'))
			{
				return TRUE;
			}
		}

		$valid = FALSE;
		foreach ($to_check->roles as $role)
		{
			foreach ($role->permissions as $permission)
			{
				if (in_array($permission->name, $permissions))
				{
					$valid = TRUE;
					break 2;
				}
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

		$to_check = $this->get_to_check();

		$valid = FALSE;
		foreach ($to_check->roles as $role)
		{
			// Is the role in array, or is user Super Admin
			if (in_array($role->name, $roles) || $role->name == \Config::get('verify::verify.super_admin'))
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
		$to_check = $this->get_to_check();

		$max = -1;
		$min = 100;
		$levels = array();

		foreach ($to_check->roles as $role)
		{
			$max = $role->level > $max
				? $role->level
				: $max;

			$min = $role->level < $min
				? $role->level
				: $min;

			$levels[] = $role->level;
		}

		switch ($modifier)
		{
			case '=':
				return in_array($level, $levels);
				break;

			case '>=':
				return $max >= $level;
				break;

			case '>':
				return $max > $level;
				break;

			case '<=':
				return $min <= $level;
				break;

			case '<':
				return $min < $level;
				break;

			default:
				return false;
				break;
		}
	}

	/**
	 * Get to check
	 *
	 * @return object
	 */
	private function get_to_check()
	{
		$class = get_class();

		if(empty($this->to_check_cache))
		{
			$to_check = new $class;

			$to_check = $class::with(array('roles', 'roles.permissions'))
				->where('id', '=', $this->get_attribute('id'))
				->first();

			$this->to_check_cache = $to_check;
		}
		else
		{
			$to_check = $this->to_check_cache;
		}

		return $to_check;
	}

}
