# phantomjs.rb

[![Build Status](https://secure.travis-ci.org/westoque/phantomjs.rb.png?branch=master)](http://travis-ci.org/westoque/phantomjs.rb)

A ruby wrapper for phantomjs.

## Requirements

You have to have `phantomjs` installed.

## Install

```sh
gem install phantomjs.rb
```

## Usage

```rb
script = File.expand_path('my_runner.js')
output = Phantomjs.run(script, 'myarg1', 'myarg2')
p output # Whatever it outputs from STDOUT
```

## License

MIT
