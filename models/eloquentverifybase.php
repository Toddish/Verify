<?php

namespace Verify\Models;

class EloquentVerifyBase extends \Eloquent
{

	protected $prefix = '';

	/**
	 * Construct
	 * 
	 * @param array   $attributes
	 * @param boolean $exists
	 */
	public function __construct($attributes = array(), $exists = false)
	{
		parent::__construct($attributes, $exists);

		// Set the prefix
		$prefix = \Config::get('verify::verify.prefix');

		$this->prefix = $prefix
			? $prefix.'_'
			: '';
	}

	/**
	 * Get the table name
	 * 
	 * @return string
	 */
	public function table()
	{
		$table = parent::table();

		$table = $this->prefix
			? $this->prefix.$table
			: $table;

		return $table;
	}

}