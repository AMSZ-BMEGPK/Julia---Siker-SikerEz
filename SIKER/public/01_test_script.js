console.log("01_test_script.js file is connected!")

submit_button.addEventListener("click", getKPOI); // Button click event listener

var canvas = document.getElementById("myCanvas"); // Defining canvas object
var context = canvas.getContext("2d"); // Defining the context of the canvas


window.onload = function() { // Fucntion is called when the window is loaded
  context.translate(10,490); // Setting the zero point of the canvas
  context.scale(1, -1); // Flipping the "y" axis, so it points upwards
  drawArrow(context, 0, 0, 50, 0, 2, 'red'); // Drawing "x" axis
  drawArrow(context, 0, 0, 0, 50, 2, 'green'); // Drawing "y" axis
}

function getKPOI() { // Function to trigger when submit button is pressed
  //TODO: need to refresh the canvas every time when something is added/removed

  let KPOI = document.getElementById('KPOI').value // Getting value of KPOI form
  console.log("Keypoint: ", KPOI); // Console log of this value

  let KPOI_string = KPOI.toString(); // KPOI number to print out
  let textOffset = 8; // Text poffset for KPOI number

  let Xcoord = document.getElementById('Xcoord').value // Getting value of KPOI coordinates
  let Ycoord = document.getElementById('Ycoord').value

  console.log("x-coordinate: ", Xcoord)
  console.log("y-coordinate: ", Ycoord)
 

  context.beginPath(); // Drawing KPOI circle
  context.fillStyle = "black";
  context.arc(Xcoord, Ycoord, 5, 0, 2 * Math.PI, false);
  context.fill();

  context.beginPath(); // Drawing KPOI number above right
  context.font = "16px Georgia";
  context.fillStyle = "blue";
  context.translate(Xcoord, Ycoord); // Because the inverted canvas, we need to translate to the KPOI
  context.scale(1, -1); // Then rotate the canvas again, so KPOI text is up right
  context.fillText(KPOI_string, textOffset, -textOffset); // Drawing KPOI number
  context.scale(1, -1); // Rotate the canvas back 
  context.translate(-Xcoord, -Ycoord);
  context.fill();




}

function drawArrow(ctx, fromx, fromy, tox, toy, arrowWidth, color){ // Function to draw arrow
  //variables to be used when creating the arrow
  var headlen = 10;
  var angle = Math.atan2(toy-fromy,tox-fromx);

  ctx.save();
  ctx.strokeStyle = color;
  ctx.fillStyle = color;

  //starting path of the arrow from the start square to the end square
  //and drawing the stroke
  ctx.beginPath();
  ctx.moveTo(fromx, fromy);
  ctx.lineTo(tox, toy);
  ctx.lineWidth = arrowWidth;
  ctx.stroke();

  //starting a new path from the head of the arrow to one of the sides of
  //the point
  ctx.beginPath();
  ctx.moveTo(tox, toy);
  ctx.lineTo(tox-headlen*Math.cos(angle-Math.PI/7),
             toy-headlen*Math.sin(angle-Math.PI/7));

  //path from the side point of the arrow, to the other side point
  ctx.lineTo(tox-headlen*Math.cos(angle+Math.PI/7),
             toy-headlen*Math.sin(angle+Math.PI/7));

  //path from the side point back to the tip of the arrow, and then
  //again to the opposite side point
  ctx.lineTo(tox, toy);
  ctx.lineTo(tox-headlen*Math.cos(angle-Math.PI/7),
             toy-headlen*Math.sin(angle-Math.PI/7));

  //draws the paths created above
  ctx.stroke();
  ctx.fill();
  ctx.restore();
}