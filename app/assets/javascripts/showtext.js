  $(document).ready(function() {
      let showText = function (target, message, index, interval) {
    if (index < message.length) {
      if (message[index] === '\n') {
      $(target).append('<br/>');
      } else {
      $(target).append(message[index]);
    }
    index += 1
      setTimeout(function () { showText(target, message, index, interval); }, interval);
    }
  }
  if (document.getElementById("description")) {
  showText("#description", "Explore the best spots for the next 7 days.\nYour ride is awaiting.", 0, 50)
  }
  })
