module OneDHeatsController
    using Genie.Renderer.Html

    function calculate(resolution)
        x = collect(range(0,10,length=resolution))
        y = [xi*xi for xi in x]
        return y
    end    

    function show_results()
        html(:onedheat, :ondheatview)
    end

    function show_calculation(resol)
        y = calculate(resol)
        html(:onedheat, :calculated, T=y)
    end

end
