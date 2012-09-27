# # Laravel Verify Bundle

*A simple role/permission authentication bundle for Laravel*

+  Secure password storage with salt
+  Role/permission based authentication
+  Exceptions for intelligent handling of errors
+  Configurable/extendable

**NOTE:** Full docs will be available soon(ish) from my portfolio.

## Installation

Run this command on the CLI:

    php artisan bundle:install verify  

### Registering the Bundle

Place the following code in ``application/bundles.php``:


    'verify'    => array(
        auto        => true
    )


Then change your Auth driver to ``'verify'`` in ``application/config/auth.php``:

    'driver' => 'verify',

Now migrate the resources for Verify:

    php artisan migrate verify

You should now have all the tables imported, complete with a sample user, called **admin**, with a password of **password**.

## Usage

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

### Public Functions

#### User Model

The main functions are supposed to be used with a User object.

    $user = Auth::retrieve($user_id);
  
    // Roles
    $user->is('Super Admin'); // Does the user have the role 'Super Admin'  
    $user->is(array('Super Admin', 'Admin')); // Does the user have the role 'Super Admin' OR 'Admin'
  
    // Permissions
    $user->can('delete_users'); // Does the user have the permission 'delete_users'
    $user->can(array('delete_users', 'create_users')); // Does the user have the permission 'delete_users' OR 'create_users'
  
    // Levels
    $user->level(7); // Is the user a level 7 or above?
    $user->level(5, '<='); // Is the user a level 5 or below
    // All the standard operators are valid (<, <=, =, >=, >)

**NOTE:** Salts are automatically applied when setting a password:

    $user->password = 'password'; // Salt will automatically be generated and applied to the user


#### Verify Library

The Verify library has the same permission functions as the User model, the only difference being it tests the logged in user by default, or you can pass a user in as a parameter.

    // Roles
    Auth::is(array('Super Admin', 'Admin');
    Auth::is('Admin', $different_user);

    // Permissions
    Auth::can(array('create_users', 'delete_users');
    Auth::can('create_users', $different_user);

    // Levels
    Auth::level(7);
    Auth::level(5, '<');
    Auth::level(9, '<=', $different_user);

It also has these public functions, like the normal Auth driver.

##### retrieve($user_id):object|null  
*Retrieves a user via their ID*

    $user = Auth::retrieve($user_id);

##### attempt($arguments = array()):boolean  
*Attempts to log in a user*

    $ok = Auth::attempt(array(
        'username' => 'Todd',
        'password' => 'password',
        'remember' => true
    ));

The only real difference between this and the normal ```attempt``` Auth method, is it throws an exception on error:

*UserNotFoundException* - User can't be found  
*UserUnverifiedException* - User isn't verified  
*UserDisabledException* - User has been disabled  
*UserDeletedException* - User has been deleted

### Configuration

A separate config file is provided to keep configuration separate from other Auth libraries.


#### username
*A string or array of the database columns to authenticate against*  

    array('username', 'email')

#### user_model
*The model to use for a User*  

    'Verify\Models\User'

#### super_admin
*The name of the super admin, who returns true on all permission checks*

    'Super Admin'

#### prefix
*The prefix to use for the database tables. e.g 'verify' for 'verify_users'*

    ''
