# local_time_helper.cr

Crystal implementation of view helper from https://github.com/basecamp/local_time

[![Build Status](https://travis-ci.org/anamba/local_time_helper.cr.svg?branch=master)](https://travis-ci.org/anamba/local_time_helper.cr)
[![Version](https://img.shields.io/github/tag/anamba/local_time_helper.cr.svg?maxAge=360)](https://github.com/anamba/local_time_helper.cr/releases/latest)
[![License](https://img.shields.io/github/license/anamba/local_time_helper.cr.svg)](https://github.com/anamba/local_time_helper.cr/blob/master/LICENSE)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  local_time_helper:
    github: anamba/local_time_helper.cr
```

Add the `local-time` js to your project using npm or yarn.

## Usage

Made to be used with Amber, but will probably work fine in other situations. Require/include like other helpers.

```crystal
require "local_time_helper"
```

```crystal
include LocalTimeHelper
```

## Development

It's not a complete implementation of everything the ruby gem does, just enough to get the specs to pass (translated the relevant tests from the original).
Contributions welcome if it doesn't support the options you need.

## Contributing

1. Fork it (<https://github.com/anamba/local_time_helper.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [anamba](https://github.com/anamba) Aaron Namba - creator, maintainer
