console.log('bar');
for (var i = 0; i < phantom.args.length; i++) {
   console.log(phantom.args[i]);
}
phantom.exit();
