# Laravel Verify Bundle

*A simple role/permission authentication bundle for Laravel*

### Installation

Run these commands on the CLI:

    php artisan bundle:install verify  
    php artisan migrate verify

Or, if you're not a fan of the CLI:

1.  Copy the bundle files to your bundle directory
2.  Import verify.sql into your database.

You should now have all the tables imported, complete with a sample user, called **admin**, with a password of **password**.

### Registering the Bundle

Place the following code in ``application/bundles.php``:


    'verify'	=> array(
	    auto		=> true
    )


Then change your Auth driver to ``'verify'`` in ``application/config/auth.php``:

    'driver' => 'verify',

### Usage

The bundle is intentionally lightweight. You add Users, Roles and Permissions like any other Model.

    $user = Verify\Models\User::create(array(...));
    $role = Verify\Models\User::create(array(...));

etc. 

**All models are in the namespace 'Verify\Models\'.**

The relationships are as follows:

+  Roles have many Users
+  A User belongs to a Role
+  Roles have many and belongs to Permissions
+  Permissions have many and belongs to Roles

They are added via the ORM, too:

    $role->permissions->sync(array($permission->id));

More information on relationships can be found in the [Laravel Eloquent docs](http://laravel.com/docs/database/eloquent).


#### Public Functions

##### retrieve($user_id):object|null  
*Retrieves a user via their ID*

    $user = Verify::retrieve($user_id);

##### attempt($arguments = array()):boolean  
*Attempts to log in a user*

    $ok = Verify::attempt(array(
        'username' => 'Todd',
        'password' => 'password',
        'remember' => true
    ));

The only real difference between this and the normal ```attempt``` Auth method, is it throws an exception on error:

*UserNotFoundException* - User can't be found  
*UserUnverifiedException* - User isn't verified  
*UserDisabledException* - User has been disabled  
*UserDeletedException* - User has been deleted

##### is($roles, $user = NULL):boolean
*Checks if a user is a certain role*

    $ok = Verify::is(array('Super Admin', 'Admin');
    $ok = Verify::is('Admin', $different_user);

If no user is passed, the currently logged in user is tested against.  
If an array of Role names are a passed, the function returns true if **any one** of them is valid.

##### can($permissions, $user = NULL):boolean
*Checks if a user has a certain permission*

    $ok = Verify::can(array('create_users', 'delete_users');
    $ok = Verify::can('create_users', $different_user);

If no user is passed, the currently logged in user is tested against.  
If an array of Permission names are a passed, the function returns true if **any one** of them is valid.  
If the user being tested against is a ```'Super Admin'```, as defined in the config below, this method will always return true.

##### level($level, $modifier = '>=', $user = NULL):boolean
*Checks if a user is a certain level*

    $ok = Verify::level(7); // Is the User level 7 or above
    $ok = Verify::level(5, '<'); // Is the User below level 5
    $ok = Verify::level(9, '<=', $different_user);

If no user is passed, the currently logged in user is tested against.

### Configuration

A separate config file is provided to keep configuration separate from other Auth libraries.


##### username
*A string or array of the database columns to authenticate against*  

    array('username', 'email')

##### user_model
*The model to use for a User*  

    'Verify\Models\User'

##### super_admin
*The name of the super admin, who returns true on all permission checks*

    'Super Admin'

