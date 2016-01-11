var page = new WebPage();
console.log(phantom.args[0]);
page.open(phantom.args[0], function(status) {
  console.log(status);
  phantom.exit();
});
