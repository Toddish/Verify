<?php

class Verify_Init {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('permissions', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->string('name', 100)->index();
			$table->string('description', 255);
			$table->timestamps();
		});

		Schema::create('roles', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->string('name', 100)->index();
			$table->string('description', 255);
			$table->integer('level');
			$table->timestamps();
		});

		Schema::create('users', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->string('username', 30)->index();
			$table->string('password', 60)->index();
			$table->string('salt', 32);
			$table->string('email', 255)->index();
			$table->integer('role_id')->index();
			$table->boolean('confirmed');
			$table->boolean('disabled');
			$table->boolean('deleted');
			$table->timestamps();

			$table->foreign('role_id')->references('id')->on('roles');
		});

		Schema::create('permission_role', function($table)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->integer('permission_id');
			$table->integer('role_id');
			$table->timestamps();

			$table->foreign('permission_id')->references('id')->on('permissions');
			$table->foreign('role_id')->references('id')->on('roles');
		});

		DB::table('roles')->insert(array(
			'name'				=> Config::get('verify::verify.super_admin'),
			'level'				=> 10
		));

		DB::table('users')->insert(array(
			'username'			=> 'admin',
			'password'			=> '$2a$08$rqN6idpy0FwezH72fQcdqunbJp7GJVm8j94atsTOqCeuNvc3PzH3m',
			'salt'				=> 'a227383075861e775d0af6281ea05a49',
			'role_id'			=> 1,
			'email' 			=> 'example@gmail.com',
			'created_at'		=> date('Y-m-d H:i:s')
		));
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('permission_role');
		Schema::drop('users');
		Schema::drop('roles');
		Schema::drop('permissions');
	}

}