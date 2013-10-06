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
var arg1 = phantom.args[0];
var arg2 = phantom.args[1];
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

Well it works for that too!

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

## Running the tests

```
bundle exec rake spec
```

## License

MIT
