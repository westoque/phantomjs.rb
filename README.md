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

### Pass a file

Use `Phantomjs.run` to run the passed script file.

```js
// my_runner.js
var system = require("system")
var arg1 = system.args[0];
var arg2 = system.args[1];
console.log(arg1 + ' ' + arg2);
```

Then in ruby:

```rb
Phantomjs.run('my_runner.js', 'hello', 'world')
#=> 'hello world'
```

### Pass a script

You can also pass a javascript string as an argument and call
`Phantomjs.inline`. This will create a temporary file for it
and run the script.

NOTE: Just don't forget to call `phantom.exit`.

```rb
js = <<JS
  console.log(phantom.args[0] + ' ' + phantom.args[1]);
  phantom.exit();
JS

Phantomjs.inline(js, 'hello', 'world')
#=> 'hello world'
```

### But what about async scripts?

Well it works for that too! Just pass a `block` to the method call and the
argument will be whatever your script puts out on `stdout`.

```rb
js = <<JS
  ctr = 0;
  setInterval(function() {
    console.log('ctr is: ' + ctr);
    ctr++;

    if (ctr == 3) {
      phantom.exit();
    }
  }, 5000);
JS

Phantomjs.inline(js) do |line|
  p line
end
#=> ctr is: 0
    ctr is: 1
    ctr is: 2
```

## Configuring the path to phantomjs

If you are using phantomjs in a non-typical installation path or are including the
binary inside your application, you can configure phantomjs.rb to use a custom path.

The following example is a good starting point to follow.

```rb
osx = Rails.env.development? || Rails.env.test?
Phantomjs.configure do |config|
  config.phantomjs_path = "#{Rails.root}/bin/phantomjs-#{osx ? 'osx' : 'x86'}"
end
```

## Running the tests

```
bundle exec rake spec
```

## License

MIT
