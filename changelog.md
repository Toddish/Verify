# Changelog

## v 2.0.0
+ Added DB prefix (#3)
+ Moved permission/role logic to User model
+ Updated Readme.md
+ Created changelog

### Upgrade Instructions
Back up your config, update the bundle. Copy back in your config, then add the following:

    'prefix'    => ''

If want a prefix, and you've already created the tables with the migration, simply prefix them yourself and add it to the config. **NO** underscore necessary, it'll automatically be added. ('verify' will create 'verify_users', for instance.)

## v 1.0.1
+ Changed migration User column 'confirmed' to 'verified' to match the code (#1)
+ Fixed Auth::is() not returning correctly unless a User had been checked (#2)

### Upgrade Instructions
Bit of a mess, but you'll basically have to change the column yourself, as you can only drop/add columns in Laravel, not alter them!

## v 1.0.0
+ Initial commit!