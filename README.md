# phantomjs.rb

[![Build Status](https://secure.travis-ci.org/westoque/phantomjs.rb.png?branch=master)](http://travis-ci.org/westoque/phantomjs.rb)

A ruby wrapper for phantomjs. The binaries are in `vendor` and it will
automatically detect what OS you are using and will try to use the
appropriate binaries.

## Install

```sh
gem install phantomjs.rb
```

## Usage

```rb
script = File.expand_path('./my_runner.js')
output = Phantomjs.run(script, 'myarg1', 'myarg2')
p output # Whatever it outputs from stdout
```

The equivalent code above will generate:

```sh
/absolute/path/to/phantomjs /absolute/my_runner.js myarg1 myarg2
```
