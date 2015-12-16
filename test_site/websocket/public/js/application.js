var scheme = "ws://";
var uri = scheme + window.document.location.host + "/faye";
ws = new WebSocket(uri);

ws.onopen = function(event) {
  ws.send("This message is coming from onopen in application.js");
  console.log("Message has been sent from ws.onopen");
}

ws.onmessage = function(message) {
  var data = JSON.parse(message.data);
  $("#chat-text").append("<div class='panel panel-default'><div class='panel-heading'>" + data.handle + "</div><div class='panel-body'>" + data.text + "</div></div>");
  $("#chat-text").stop().animate({
    scrollTop: $('#chat-text')[0].scrollHeight
  }, 800);
};

$("#input-form").on("submit", function(event) {
  event.preventDefault();
  alert("form is firing");
  // var handle = $("#input-handle")[0].value;
  var text   = $("#input-text")[0].value;
  ws.send(JSON.stringify({text: text }));
  $("#input-text")[0].value = "";
});
