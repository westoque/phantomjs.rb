# phantomjs.rb

A ruby wrapper for phantomjs. The binaries are in `vendor` and it will
automatically detect what OS you are using and will try to use the
appropriate binaries.

## Install

```sh
gem install phantomjs.rb
```

## Usage

```rb
output = Phantomjs.run(script_name, arg1, arg2)
p output # Whatever it outputs from stdout
```
