<?php

namespace Verify\Models;

class User extends \Eloquent
{
	
	public static $accessible = array('username', 'password', 'salt', 'email', 'role_id', 'verified', 'deleted', 'disabled');

	public function role()
	{
		return $this->belongs_to('Verify\Models\Role');
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

}