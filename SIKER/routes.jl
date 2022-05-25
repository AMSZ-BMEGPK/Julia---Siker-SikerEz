using Genie.Router
using  RectanglesController
using Genie.Requests

global belso = 3
route("/") do
  serve_static_file("welcome.html")
end

route("/rw") do 
  RectanglesController.rectangle_view(200,200)
end
route("/rw", method = POST) do 
  a = postpayload(:fname,"100")
  b = postpayload(:lname,"200")
  RectanglesController.rectangle_view(a,b)
end

route("/ask_for_input") do 
  serve_static_file("asking_for_input.html")
end


