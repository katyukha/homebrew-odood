# Odood - Manage local development odoo installations with ease

The easy way to install and manage odoo for local development.

---

![Current status](https://img.shields.io/badge/Current%20Status-Beta-purple)
[![Docs](https://img.shields.io/badge/Docs-Odood-green)](https://katyukha.github.io/Odood/)

---

## How do I install this formulae?

`brew install katyukha/odood/odood`

Or `brew tap katyukha/odood` and then `brew install odood`.

Or, in a [`brew bundle`](https://github.com/Homebrew/homebrew-bundle) `Brewfile`:

```ruby
tap "katyukha/odood"
brew "odood"
```

## Overview

This project aims to simplify the process of development and maintenance
of addons developer for Odoo.

This project is successor of [odoo-helper-scripts](https://katyukha.gitlab.io/odoo-helper-scripts/)

Following features available:
- Super easy installation of Odoo for development
- Super easy installation of Odoo for production (see [docs](./production-deployment.md))
- Simple way to manage multiple development instances of Odoo on same developer's machine
- Everything (including [nodejs](https://nodejs.org/en/)) installed in [virtualenv](https://virtualenv.pypa.io/en/stable/) - no conflicts with system packages
- Best test runner for Odoo modules:
    - Easy run test for developed modules
    - Show errors in the end of the log, that is really useful feature for large (few megabytes size test logs)
    - Test module migrations with ease
- Super easy of third-party addons installation:
    - Install modules directly from Odoo Apps
    - Easily connect git repositories with Odoo modules to Odoo instance managed by Odood
    - Automatic resolution of addons dependencies:
        - Handle `requirements.txt`
        - Handle [`odoo_requirements.txt`](https://katyukha.gitlab.io/odoo-helper-scripts/odoo-requirements-txt/)
- Simple database management via commandline: create, backup, drop, rename, copy database
- Simple installation via prebuilt debian package (see [releases](https://github.com/katyukha/Odood/releases))
- Support for [assemblies](./assembly.md): single repo with all addons for project, populated in semi-automatic way.
- Build with docker-support in mind


## The War in Ukraine

2022-02-24 Russia invaded Ukraine...

If you want to help or support Ukraine to stand against russian inavasion,
please, visit [the official site of Ukraine](https://war.ukraine.ua/)
and find the best way to help.

Thanks.

## Quick start

Use following command to create new local (development) odoo instance:

```bash
odood init -v 18 -i odoo-18.0 --db-user=odoo18 --db-password=odoo --http-port=18069
```

This command will create new virtual environment for Odoo and install odoo there.

**Note**, it is required to create database user `odoo18` with password `odoo` by yourself, to make odoo able to connect to database.

Next, change current working directory to directory where we installed Odoo:

```bash
cd odoo-18.0
```

After this, just run command:

```bash
odood browse
```

and it will automatically start Odoo and open it in browser.

Next, you can use following commands to manage server:

```bash
odood server start
odood server stop
odood server restart
odood server log
```

Next, let's create some test database with pre-installed CRM module
for this instance:

```bash
odood db create --demo my-test-database --install=crm
```

After this command, you will have created odoo database `my-test-database` with
already installed module `crm`.

Additionally you can manage odoo addons from commandline via command `odood addons`.
See help for this command for more info:

```bash
odood addons --help
```

It is possible to easily add repositories with third-party addons to odood projects.
To do this, following command could be used

```bash
odood repo add --help
```

For example, if you want to add [crnd-inc/generic-addons](https://github.com/crnd-inc/generic-addons)
you can run following command:

```bash
odood repo add --github crnd-inc/generic-addons
```

## Documentation

- [Odood documentation](https://katyukha.github.io/Odood/)
- [Homebrew's documentation](https://docs.brew.sh).
