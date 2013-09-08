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

For example, your phantomjs script would look like this:

```js
// my_runner.js
var arg1 = phantom.args[0];
var arg2 = phantom.args[1];
console.log(arg1 + ' ' + arg2);
```

Then in ruby, you can then do:

```rb
script = File.expand_path('my_runner.js')
Phantomjs.run(script, 'hello', 'world')
#=> 'hello world'
```

## Running the tests

```
bundle exec rake spec
```

## License

MIT
