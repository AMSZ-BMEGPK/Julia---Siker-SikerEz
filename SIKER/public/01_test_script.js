submit_button.addEventListener("click", getKPOI); // Button click event listener


function getKPOI() { // Function to trigger when submit button is pressed

  let KPOI = document.getElementById('KPOI').value // Getting value of KPOI form
  console.log("Keypoint: ", KPOI) // Console log of this value

  let Xcoord = document.getElementById('Xcoord').value
  let Ycoord = document.getElementById('Ycoord').value

  console.log("x-coordinate: ", Xcoord)
  console.log("y-coordinate: ", Ycoord)
}
