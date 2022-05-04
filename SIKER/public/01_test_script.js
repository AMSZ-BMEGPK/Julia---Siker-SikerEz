console.log("01_test_script.js file is connected!")

submit_button.addEventListener("click", getKPOI); // Button click event listener

// ------------------------------------------------------------------------------- // 

var canvas = document.getElementById("myCanvas"); // Defining canvas object
var context = canvas.getContext("2d"); // Defining the context of the canvas


function getKPOI() { // Function to trigger when submit button is pressed

  let KPOI = document.getElementById('KPOI').value // Getting value of KPOI form
  console.log("Keypoint: ", KPOI) // Console log of this value

  let Xcoord = document.getElementById('Xcoord').value
  let Ycoord = document.getElementById('Ycoord').value

  console.log("x-coordinate: ", Xcoord)
  console.log("y-coordinate: ", Ycoord)

  context.clearRect(0, 0, canvas.width, canvas.height) // Clear canvas before drawing
  context.beginPath(); // Begin drawing in canvas
  context.arc(Xcoord, Ycoord, 10, 0, 2*Math.PI); // Create an arc at Xcoord, Ycoord with R = 10
  context.closePath();
  context.fill();

}