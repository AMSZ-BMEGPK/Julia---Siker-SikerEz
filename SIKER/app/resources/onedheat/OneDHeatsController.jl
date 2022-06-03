module OneDHeatsController
    using Genie.Renderer.Html

    using LinearAlgebra

function FEM(resolution)
    n = resolution # number of finite elements
    a = 0 #left side
    b=2 # right side
    l=b-a #length
    grad = 1 #linear
    RB_1 = 1 #Dirichlet on the link site
    RB_2 = 50 # Neumann on the right side

    q, edof = netz(n,grad,a,b)
    ed = extract(edof,q)
    
    ndof = length(q)
    K = zeros(ndof, ndof)
    F = zeros(ndof,1)

    # Elementroutine + Assembly
    for i in range(1,n,step=1)
        Ke,Fe = element(ed[i,:])
        K = assem(K,Ke,edof[i,:])
        F = assem(F,Fe,edof[i,:])
    end
    # Dirichlet bc
    bc  =[1 RB_1]
    #Neumann bc
    F[ndof] = F[ndof] + RB_2
    u = solveq(K,F,bc)
    # plot(q,u)
    # println(q)
    # println(edof)
    # print(ed)
    # println(ndof)
    # display(K)
    # display(F)
    # display(u)
    return u
end
function netz(n,grad, a,b)
    if grad != 1
        throw(ArgumentError("Higher order FEM is not implemented yet"))
    end    
    q = collect(range(a,b,length=n+1))
    edof = zeros(Base.Int32,n,grad+1)
    for i in range(1,n,step=1)
        edof[i,:] = [i i+1]
    end
    return q,edof
end    
function extract(edof,q)
    ed = zeros(size(edof))
    map!(x -> q[x],ed,edof)
    #print(ed)
    return ed
end
function element(qe)
    #Ke = ones(2,2)
    #Fe = ones(2,1)
    nGp = 2 #defining gauss points
    g1 = 1/sqrt(3)
    w1 = 1
    xi = [-g1;g1]
    w = [w1;w1]
    
    #Formfunctions (Lagrange; linear)
    N=zeros(2,2)
    N[:,1] = (1 .-xi)./2
    N[:,2] = (1 .+xi)./2
    # Derivation with respect xi
    dNdxi = zeros(2,2)
    dNdxi[:,1] = -0.5*ones(nGp,1)
    dNdxi[:,2] = +0.5*ones(nGp,1)
    #Jacobian-matrix
    he = qe[2]-qe[1]
    J = he/2
    #Intitialization
    Ke = zeros(2,2)
    Fe = zeros(2,1)

    #left side
    f = (-6)*qe+12*qe.^2 + (-20)*qe.^3 .+ 6
    #doing the actual calculations
    detJ = det(J)
    dNx = dNdxi/J
    for j in range(1,nGp,step=1)
        Ke = Ke + ((dNx[j,:]) * transpose(dNx[j,:]))  .*(detJ*w[j])
        Fe = Fe .+ N[j,:].*(N[j,:]'f) .*(detJ*w[j])
    end

    return Ke,Fe
end
function assem(O,Oe,dof)
    nRows, nCols = size(Oe)
    if nRows == nCols
        O[dof,dof]=O[dof,dof] + Oe
    else
        O[dof] = O[dof] + Oe 
    end
    return O
end
function solveq(K,F,bc)
    #throw(error("Something is wrong..."))
    if ! isempty(bc)
        dofDiri = bc[:,1]
        qDiri = bc[:,2]

        nDof = prod(size(F))
        DOSOLVE = trues(nDof,1)
        DOSOLVE[dofDiri] .= false
        
        q = zeros(size(K,1),1)
        #q[DOSOLVE] = K[DOSOLVE,DOSOLVE]\(F[DOSOLVE]-K[DOSOLVE,! DOSOLVE]*qDiri)
        # kmp=DOSOLVE*transpose(DOSOLVE)
        # mask = K .>0
        # grdgd = K[mask]
        # #fefe = K[[all(row.>=0) for row in eachrow(K)], all(col.>=0) for col in eachcol(K)]]
        # fefedwe=K[[all(row.>=0) for row in eachrow(K)], :]
        # fefedwe3=K[[all(row.>=0) for row in eachrow(K)], [all(col.>=0) for col in eachcol(K)]]
        # dvsr=K[all.(>=(0), eachrow(K)), :]
        # fewfwea=K[all.(>=(0), eachrow(K)), all.(>=(0), eachcol(K))]
        # reger= K[(DOSOLVE*transpose(DOSOLVE)).>0]
        # dgrr=(DOSOLVE*transpose(DOSOLVE)).>0
        # tmp = filter(DOSOLVE*transpose(DOSOLVE),K)#\(filter(DOSOLVE,F)-filter(DOSOLVE'(!DOSOLVE),K)*qDiri)
        # #q[! DOSOLVE] = qDiri
        q[2:end] = K[2:end,2:end]\(F[2:end]-K[2:end,1].*qDiri)
        q[1] = qDiri[1]
    else
        q = K\F
    end
    
    return q
end



    function squere_it(resolution) #OLD VERSION
        x = collect(range(0,10,length=resolution))
        y = [xi*xi for xi in x]
        return y
    end    

    function show_results() #OLD VERSION
        html(:onedheat, :ondheatview)
    end

    function show_calculation(resol) #OLD VERSION
        y = squere_it(resol)
        html(:onedheat, :calculated, T=y)
    end
    function show_fem(resol)
        y = FEM(resol)
        u = vec(y)
        html(:onedheat, :calculated, T=u,res=resol)
    end

end
