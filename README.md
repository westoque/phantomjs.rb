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

For example, if you have a phantomjs script like this:

```js
// my_runner.js
var arg1 = phantom.args[0];
var arg2 = phantom.args[1];
console.log(arg1 + ' ' + arg2);
```

Then in ruby:

```rb
Phantomjs.run('my_runner.js', 'hello', 'world')
#=> 'hello world'
```

## Running the tests

```
bundle exec rake spec
```

## License

MIT
