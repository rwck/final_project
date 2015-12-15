var client = new Faye.Client('http://localhost:9292/foo')

Logger = {
  incoming: function(message, callback) {
    console.log('incoming', message);
    callback(message);
  },
  outgoing: function(message, callback) {
    console.log('outgoing', message);
    callback(message);
  }
};

client.addExtension(Logger);

// client.publish('/faye', {text: "hello from your website"});
// bob = "thing"
// console.log(Bob);

var subscription = client.subscribe('/foo', function(message) {
  console.log(message);
});

subscription.then(function() {
  console.log("Subscription is now active!");
});

var publication = client.publish('/foo', {text: "Hi There"});

publication.then(function() {
  console.log("message sent to the server");
}, function(error) {
  console.log("There was a problem: " + error.message);
});

client.onmessage = function(e) {
  console.log(e.data);
  myMesssage = e.data;
}
