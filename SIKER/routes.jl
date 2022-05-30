using Genie.Router
using  RectanglesController
using OneDHeatsController
using Genie.Requests

route("/") do
  serve_static_file("welcome.html")
end
#example: Rectangles -------------------------------------------------
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
# ---------------------------------------------------------------------
#example: 1 D stat heat conduction
route("/onedheat") do 
  OneDHeatsController.show_results()
end
route("/codh") do 
  OneDHeatsController.show_calculation(11)
end


