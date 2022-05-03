using Genie.Router

route("/") do
  serve_static_file("welcome.html")
end

route("/test") do
  serve_static_file("01_test.html")
end