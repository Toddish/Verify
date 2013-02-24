# Laravel Verify Bundle

---

A simple role/permission authentication bundle for Laravel

---

* Secure password storage with salt
* Role/permission based authentication
* Exceptions for intelligent handling of errors
* Configurable/extendable

---

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

```php
$user = new Verify\Models\User;
$role = new Verify\Models\Role;
$permission = new Verify\Models\Permission;
```

etc.

**All models are in the namespace 'Verify\Models\'.**

The relationships are as follows:

* Roles have many and belong to Users
* Users have many and belgon to Roles
* Roles have many and belong to Permissions
* Permissions have many and belong to Roles

Relationships are handled via the ORM, too:

    $role->permissions()->sync(array($permission->id));

More information on relationships can be found in the [Laravel Eloquent docs](http://laravel.com/docs/database/eloquent).

## Basic Examples

```php
// Create a new Permission
$permission = new \Verify\Models\Permission;
$permission->name = 'delete_user';
$permission->save();

// Create a new Role
$role = new Verify\Models\Role;
$role->name = 'Moderator';
$role->level = 7;
$role->save();

// Assign the Permission to the Role
$role->permissions()->sync(array($permission->id));

// Create a new User
$user = new \Verify\Models\User;
$user->username = 'Todd';
$user->email = 'todd@toddish.co.uk';
$user->password = 'password'; // This is automatically salted and encrypted
$user->save();

// Assign the Role to the User
$user->roles()->sync(array($role->id));

// Using the public methods available on the User object
var_dump($user->is('Moderator')); // true
var_dump($user->is('Admin')); // false

var_dump($user->can('delete_user')); // true
var_dump($user->can('add_user')); // false

var_dump($user->level(7)); // true
var_dump($user->level(5, '&lt;=')); // false
```

---

## Documentation

For full documentation, have a look at [http://docs.toddish.co.uk/verify](http://docs.toddish.co.uk/verify).