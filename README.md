# Spicerack

Spicerack generates rake tasks to pull down resources for Hashrocket projects.

## Usage

Run `rake spicerack` to list the available spices.

Run `rake spicerack:<spice_name>` to install or update that spice.

Examples:
```
rake spicerack:minical
rake spicerack:stagehand
```

## Why

These rake tasks pull down the newest versions of their assets straight from the Github repos, so we can keep jQuery plugins and other files that don't live in gems up to date easily. Plus, this will create the UI directory for you.

## Recipes

Spicerack currently pulls a select set of plugins from the [Hashrocket Spices repo](https://github.com/hashrocket/spices).
