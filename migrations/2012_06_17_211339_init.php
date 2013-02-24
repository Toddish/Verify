<?php

class Verify_Init {

	public function __construct()
	{
		// Get the prefix
		$prefix = Config::get('verify::verify.prefix');
		$prefix = $prefix
			? $prefix.'_'
			: '';

		// Set a constant here,
		// as we need the value in the closures
		if (!defined('VERIFY_PREFIX'))
		{
			define('VERIFY_PREFIX', $prefix);
		}
	}

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{

		Schema::create(VERIFY_PREFIX.'permissions', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->string('name', 100)->index();
			$table->string('description', 255)->nullable();
			$table->timestamps();
		});

		Schema::create(VERIFY_PREFIX.'roles', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->string('name', 100)->index();
			$table->string('description', 255)->nullable();
			$table->integer('level');
			$table->timestamps();
		});

		Schema::create(VERIFY_PREFIX.'users', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->string('username', 30)->index();
			$table->string('password', 60)->index();
			$table->string('salt', 32);
			$table->string('email', 255)->index();
			$table->integer('role_id')->unsigned()->index();
			$table->boolean('verified');
			$table->boolean('disabled');
			$table->boolean('deleted');
			$table->timestamps();

			$table->foreign('role_id')->references('id')->on(VERIFY_PREFIX.'roles');
		});

		Schema::create(VERIFY_PREFIX.'permission_role', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->integer('permission_id')->unsigned()->index();
			$table->integer('role_id')->unsigned()->index();
			$table->timestamps();

			$table->foreign('permission_id')->references('id')->on(VERIFY_PREFIX.'permissions');
			$table->foreign('role_id')->references('id')->on(VERIFY_PREFIX.'roles');
		});

		DB::table(VERIFY_PREFIX.'roles')->insert(array(
			'name'				=> Config::get('verify::verify.super_admin'),
			'level'				=> 10,
			'created_at'        => date('Y-m-d H:i:s'),
			'updated_at'        => date('Y-m-d H:i:s')
		));

		DB::table(VERIFY_PREFIX.'users')->insert(array(
			'username'			=> 'admin',
			'password'			=> '$2a$08$rqN6idpy0FwezH72fQcdqunbJp7GJVm8j94atsTOqCeuNvc3PzH3m',
			'salt'				=> 'a227383075861e775d0af6281ea05a49',
			'role_id'			=> 1,
			'email' 			=> 'example@gmail.com',
			'created_at'		=> date('Y-m-d H:i:s'),
			'updated_at'        => date('Y-m-d H:i:s'),
			'verified'			=> 1,
			'disabled'			=> 0,
			'deleted'			=> 0
		));
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop(VERIFY_PREFIX.'permission_role');
		Schema::drop(VERIFY_PREFIX.'users');
		Schema::drop(VERIFY_PREFIX.'roles');
		Schema::drop(VERIFY_PREFIX.'permissions');
	}

}