# Spicerack

Spicerack generates rake tasks to pull down resources for Hashrocket projects.

## Usage

Run `rake spicerack` to list the available spices.

Run `rake spicerack:<spice_name>` to install or update that spice.

Examples:
```
rake spicerack:cask
rake spicerack:supernumber
rake spicerack:minical
rake spicerack:sortr
rake spicerack:stagehand
```

## Custom Spices

You can replace the existing spices by creating a `config/spicerack.yml` file.

Example:

```
spices:
  my_spice:
  - source: 'remote-url'
    rails:  'local-destination-path'
  - source: 'other-url'
    rails:  'other-destination-path'
```

## Why

These rake tasks pull down the newest versions of their assets straight from the Github repos, so we can keep jQuery plugins and other files that don't live in gems up to date easily. Plus, this will create the UI directory for you.

## Recipes

Spicerack currently has recipes for:

- Cask (Bourbon + additional Hashrocket mixins + whitespace reset)
- the UI directory
- [Minical](http://camerond.github.io/jquery-minical/)
- [Sortr](https://github.com/camerond/jquery-sortr)
- [Stagehand](http://camerond.github.io/stagehand/)
- [superNumber](https://github.com/shaneriley/super_number/)
