module RectanglesController
  using Genie.Renderer.Html

  struct Rect
    width::Int32
    height::Int32
  end

  const x1 = 10
  const y1 = 100

  function calculate_points()
    "
    <h1>Drawing Rect</h1>
    <div style='position:absolute; top: $(x1); right: $(y1); width: 200px; height: 100px; border: 3px solid #73AD21;'>
      contents
    </div>
    "
  end

  function rectangle_view(a,b)
    html(:rectangles, :rectangleview, x1= x1, y1=y1,w=a,h=b)
  end
  function show_results()
    a = 2
    b = 3
    html(:rectangles, :ondheatview, x1= x1, y1=y1,w=a,h=b)
  end

end
