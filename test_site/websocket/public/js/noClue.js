var client = new Faye.Client("http://localhost:9292/foo", {timeout: 120, retry: 5});

var subscription = client.subscribe('/foo');

subscription.then(function() {
  console.log("something's up")
})

var publication = client.publish("/foo", {text: "Hi there"});

publication.then(function() {
  alert("Message sent to server")
}, function(error) {
  alert("There was a problem: " + error.message);
});

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
