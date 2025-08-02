# versioner

Version: 0.0.5

[![Crystal CI](https://github.com/drhuffman12/versioner/actions/workflows/crystal.yml/badge.svg)](https://github.com/drhuffman12/versioner/actions/workflows/crystal.yml)

`Versioner` is a basic utility to help keep a repo's version in sync and updated across various files

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     versioner:
       github: drhuffman12/versioner
   ```

2. Run `shards install`

## Usage

```crystal
require "versioner"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. FORK it (<https://github.com/drhuffman12/versioner/fork>)
2. Make sure you are on the main/master BRANCH (`git branch`  `git reset --hard; git checkout master; git pull origin master`)
3. Create your FEATURE branch (`git checkout -b my-new-feature`)
4. TEST existing changes!!! (`crystal spec --error-trace`)
5. VERIFY your "Changes to be committed" (`git status`)
6. *** (Please) correctly update the VERSION!!! (Edit/Syncup `src/versioner/about.cr` and `shard.yml` and in the notes above, under "SHOULD MATCH")
7. ADD your CHANGES (`git add my-new-files`)
8. Update and VERSION your changes (`git add README.md; git add shard.yml; git add src/versioner/about.cr`)
9. TEST your changes!!! (`crystal spec --error-trace`)
10. COMMIT your changes to your new branch (`git commit -am 'my-new-feature description'`)
11. PUSH to the branch (`git push origin my-new-feature`)
12. Create a new Pull Request, get it Approved, and Merge it!

## Contributors

- [Daniel Huffman](https://github.com/drhuffman12) - creator and maintainer
