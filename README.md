# Jenkins plugins packages
With this small helper it is possible to package any Jenkins plugin as a Debian package.

## Why
The easiest way to install any software on a Linux box in an automated way (eg using puppet) is to use the built-in package manager.

## How
You need:

* ruby and [fpm](https://github.com/jordansissel/fpm)

    gem install fpm

You do:

1. edit plugins.txt
1. execute ./package

## TODO

- Create an additional package that has all plugins (with their corresponding versions) as dependencies, so you need to define only one package to be installed.
- RPM support
