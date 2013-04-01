# Changelog

## v 3.0.1
+ Removed dependency on id column

### Credits
Thanks to [AoSiX](https://github.com/AoSiX) for rasing the issue and submitting a pull request.

## v 3.0.0
+ Changed user/role relationship to many-to-many

### Upgrade instructions

Back up your config, update and migrate the bundle.
Migrating will transfer your roles across, but it **will break your code**! You'll need to reflect the new relationship when assigning a Role to a User. See [the docs](http://docs.toddish.co.uk/verify#basic-usage) for more information.

## v 2.1.3
+ Fixed #19 & #20

### Credits
Thanks to [allartk](https://github.com/allartk) for raising the issues!

## v 2.1.2
+ Added a license

## v 2.1.1
+ Fixed README.md code highlighting

## v 2.1.0
+ Fixed identity column check (#15)
+ Fixed level check with '=' modifier (#16)
+ Added new Exception (#18)
+ Updated Readme.md to reflect new docs site

### Upgrade instructions
Back up your config, update the bundle.

### Credits
A **huge** thanks to [edvinaskrucas](https://github.com/edvinaskrucas) for all the pull requests (#15, #16 and #18)!

## v 2.0.3
+ Updated the changelog

## v 2.0.2
+ Added cache system for can method (#10)
+ Updated readme to avoid confusion when migrating the bundle (#11, #12)

### Upgrade instructions
Back up your config, update the bundle

### Credits
[bllim](https://github.com/bllim) for #10
[dshoreman](https://github.com/dshoreman) for #12

## v 2.0.1
+ Fixed migration issue (#5)

### Upgrade instructions
Back up your config, update the bundle.

### Credits
A **massive** thanks to [dshoreman](https://github.com/dshoreman) for fixing #5!

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