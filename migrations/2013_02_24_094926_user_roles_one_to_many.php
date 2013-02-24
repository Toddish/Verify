<?php

class Verify_User_Roles_One_To_Many {

	public function __construct()
	{
		// Get the prefix
		$prefix = Config::get('verify::verify.prefix');
		$prefix = $prefix
			? $prefix.'_'
			: '';

		$this->prefix = $prefix;
	}

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		$prefix = $this->prefix;

		Schema::create($prefix.'role_user', function($table) use ($prefix)
		{
			$table->engine = 'InnoDB';

			$table->increments('id');
			$table->integer('user_id')->unsigned()->index();
			$table->integer('role_id')->unsigned()->index();
			$table->timestamps();

			$table->foreign('user_id')->references('id')->on($prefix.'users');
			$table->foreign('role_id')->references('id')->on($prefix.'roles');
		});

		$users = DB::table($prefix.'users')->get();

		foreach ($users as $user)
		{
			DB::table($prefix.'role_user')->insert(array(
				'user_id'				=> $user->id,
				'role_id'				=> $user->role_id,
				'created_at'        	=> $user->created_at,
				'updated_at'        	=> $user->updated_at
			));
		}

		Schema::table($prefix.'users', function($table) use($prefix)
		{
			$table->drop_foreign($prefix.'users_role_id_foreign');
			$table->drop_index($prefix.'users_role_id_index');
			$table->drop_column('role_id');
		});
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		$prefix = $this->prefix;

		Schema::table($prefix.'users', function($table) use ($prefix)
		{
			$table->integer('role_id')->unsigned()->index();
		});

		$users = DB::table($prefix.'users')->get();

		foreach ($users as $user)
		{
			$role = DB::table($prefix.'role_user')
				->where('user_id', '=', $user->id)
				->order_by('created_at', 'DESC')
				->first();

			DB::table($prefix.'users')
				->where('id', '=', $user->id)
				->update(array(
					'role_id'				=> $role->role_id
				));
		}

		Schema::table($prefix.'users', function($table) use ($prefix)
		{
			$table->foreign('role_id')->references('id')->on($prefix.'roles');
		});

		Schema::drop($prefix.'role_user');
	}

}