function switchCSS() {
  if (gon.text == "on") {
    turnBlue();
  } else {
    turnYellow();
  }
}

// function testLightLevel() {
//   if (gon.light_level < 400) {
//     turnBlue();
//   } else {
//     turnYellow();
//   }
// }

function turnBlue() {
  $(".main-container").removeClass().addClass("main-container switched-off");
}

function turnYellow() {
  $(".main-container").removeClass().addClass("main-container switched-on");
}

// testLightLevel();
// switchCSS();
