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
  showText("#description", "Kitesurfing is your life?\nExplore the best spots for the next 7 days.", 0, 50)
  }
  })
