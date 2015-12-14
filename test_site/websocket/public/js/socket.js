var client = new Faye.Client('http://localhost:9292/faye')

// client.publish('/faye', {text: "hello from your website"});
// bob = "thing"
// console.log(Bob);

var subscription = client.subscribe('/faye', function(message) {
  console.log(message);
});

subscription.then(function() {
  console.log("Subscription is now active!");
});

var publication = client.publish('/faye', {text: "Hi There"});

publication.then(function() {
  console.log("message sent to the server");
}, function(error) {
  console.log("There was a problem: " + error.message);
});

client.onmessage = function(e) {
  console.log(e.data);
  myMesssage = e.data;
}
