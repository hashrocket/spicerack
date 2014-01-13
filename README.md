# Spicerack

Spicerack-rails is collection of Rails generators for Hashrocket projects.

## Usage

```
rake spicerack:cask
rake spicerack:supernumber
rake spicerack:minical
rake spicerack:sortr
rake spicerack:stagehand

rake spicerack:list
```

## Why

These generators `curl` the newest versions of their assets straight from the Github repos, so we can keep jQuery plugins and other files that don't live in gems up to date easily. Plus, this will create the UI directory for you.

## Recipes

Spicerack currently has recipes for:

- Cask (Bourbon + additional Hashrocket mixins + whitespace reset)
- the UI directory
- [Minical](http://camerond.github.io/jquery-minical/)
- [Sortr](https://github.com/camerond/jquery-sortr)
- [Stagehand](http://camerond.github.io/stagehand/)
- [superNumber](https://github.com/shaneriley/super_number/)
