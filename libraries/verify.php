<?php

/**
 * Verification Library
 *
 * @author Todd Francis
 * @version 3.0.1
 */
class Verify extends \Laravel\Auth\Drivers\Driver
{

	/**
	 * __construct
	 */
	public function __construct()
	{
		parent::__construct();

		// Populate the user variable
		$this->user();
	}

	/**
	 * Get the current user of the application.
	 *
	 * If the user is a guest, null should be returned.
	 *
	 * @param  int         $id
	 * @return mixed|null
	 */
	public function retrieve($id)
	{
		if (filter_var($id, FILTER_VALIDATE_INT) !== false)
		{
			return $this->model()->find($id);
		}
	}

	/**
	 * Attempt to log a user into the application.
	 *
	 * @param  array  $arguments
	 * @return void
	 */
	public function attempt($arguments = array())
	{
		$valid = false;

		// Get the username fields
		$usernames = Config::get('verify::verify.username');
		$usernames = (!is_array($usernames))
			? array($usernames)
			: $usernames;

		foreach ($usernames as $identify_by)
		{
			$user = $this->model()
				->where($identify_by, '=', array_get($arguments, $identify_by))
				->first();

			if (!is_null($user))
			{
				// Is user password is valid?
		                if(!Hash::check($user->salt . array_get($arguments, 'password'), $user->password))
		                {
		                    throw new UserPasswordIncorrectException('User password is incorrect');
		                }

				// Valid user, but are they verified?
				if (!$user->verified)
				{
					throw new UserUnverifiedException('User is unverified');
				}

				// Is the user disabled?
				if ($user->disabled)
				{
					throw new UserDisabledException('User is disabled');
				}

				// Is the user deleted?
				if ($user->deleted)
				{
					throw new UserDeletedException('User is deleted');
				}

				$valid = true;
				break;
			}
		}

		if ($valid)
		{
			return $this->login($user->get_key(), array_get($arguments, 'remember'));
		}
		else
		{
			throw new UserNotFoundException('User can not be found');
		}
	}

	/**
	 * Get a fresh model instance.
	 *
	 * @return Eloquent
	 */
	protected function model()
	{
		$model = Config::get('verify::verify.user_model');

		return new $model;
	}

	/**
	 * Is the User a Role
	 *
	 * @param  array|string  $roles A single role or an array of roles
	 * @param  object|integer|null  $user  Leave null for current logged in user, or pass a User ID/User object
	 * @return boolean
	 */
	public function is($roles, $user = NULL)
	{
		$user = $this->get_user($user);

		if (!$user)
		{
			return false;
		}

		return $user->is($roles);
	}

	/**
	 * Can the User do something
	 *
	 * @param  array|string $permissions Single permission or an array or permissions
	 * @param  object|integer|null  $user  Leave null for current logged in user, or pass a User ID/User object
	 * @return boolean
	 */
	public function can($permissions, $user = NULL)
	{
		$user = $this->get_user($user);

		if (!$user)
		{
			return FALSE;
		}

		return $user->can($permissions);
	}

	/**
	 * Is the User a certain Level
	 *
	 * @param  integer $level
	 * @param  string $modifier [description]
	 * @param  object|integer|null  $user  Leave null for current logged in user, or pass a User ID/User object
	 * @return boolean
	 */
	public function level($level, $modifier = '>=', $user = NULL)
	{
		$user = $this->get_user($user);

		if (!$user)
		{
			return FALSE;
		}

		return $user->level($level, $modifier);
	}

	/**
	 * Get a user
	 *
	 * @param  object|integer|null  $user  Leave null for current logged in user, or pass a User ID/User object
	 * @return object|null
	 */
	private function get_user($user = NULL)
	{
		if (!is_null($user))
		{
			// Are we passed a user ID?
			if (is_numeric($user))
			{
				$user = $this->retrieve($user);
			}
			// If $user isn't an object, we don't want it
			else if (!is_object($user))
			{
				$user = NULL;
			}
		}
		else
		{
			// Use currently logged in user
			$user = $this->user;
		}

		return $user;
	}

}

class UserNotFoundException extends Exception {};
class UserUnverifiedException extends Exception {};
class UserDisabledException extends Exception {};
class UserDeletedException extends Exception {};
class UserPasswordIncorrectException extends Exception {};
