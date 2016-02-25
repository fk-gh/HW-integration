
module HW_int

	# question 1 b) 
	# here are the packages I used

	using FastGaussQuadrature
	# using Roots
	using Sobol
	using PyPlot
	using Distributions

	# here are some functions I defined for useage 
	# in several sub questions
x = linspace(0,10,100)
	# demand function
y = exp(log(2)-0.5log(x)) # computationally cheaper version of the function from [1]
	# gauss-legendre adjustment factors for map change
j(x) = 2(0.5x+(3/2)).^(-2)
	# eqm condition for question 2
# h(p,t1,t2) = exp(t1)/p + exp(t2)/(p^{1.0/2.0}) - 2
	# this is the equilibrium condition: total demand = supply, 
	# weighted sum for integration from the slides.

	function question_1Aa(n)
fig = figure(figsize=(8,4)) 
x = linspace(0,10,100)
y = exp(log(2)-0.5log(x)) # computationally cheaper version of the function from [1]
pp1 = ones(100)
pp4 = 4*ones(100)
p0=plot(x,y,color="b",label="inverse demand");
axvline(4,color="r")
axvline(1,color="r",linewidth="2")
xlabel("p")
ylabel("q")
title("Inverse demand function")
grid("on")
legend()
	# function for question 1Aa jusst displays graphs
fig = figure(figsize=(8,4)) 
y2 = exp(log(4) - 2log(x))
plot(x,y2,label="Hello",label="demand")
xlabel("q")
ylabel("p")
xlim(0.0,7.0)
ylim(0.0,10.0)
axvline(2,color="g")
axvline(1,color="g")
axhline(4,color="r")
axhline(1,color="r",linewidth="3")
title(" ''True'' Demand function")
grid("on")
legend()
	end


	function question_1Ba(n)
   function gaussian_leg(n)
    nodes, weights = gausslegendre(n)
    dot( weights, 2(0.5nodes+(3/2)).^(-2))    
end
result = gaussian_leg(n)
print("")
println("")
println("")
println("The result of the Gauss Legendre approximation of 2 is ",result)
println("")
	end


	function question_1Bb(n)
	function mont_carl(n)
eps = rand(n) + 1; # Draw random numbers from 1 to 2 (by adding 1)
G(x) = 4x^(-2);
new = zeros(n);
for i in 1:n
    new[i] = G(eps[i]);
end
sum(new)/n
end
println("The result (one draw) of the Monte Carlo approximation of 2 is ", mont_carl(n))
	end


	function question_1Bc(n)

function mont_carl(n)
eps = rand(n) + 1; # Draw random numbers from 1 to 2 (by adding 1)
G(x) = 4x^(-2);
new = zeros(n);
for i in 1:n
    new[i] = G(eps[i]);
end
sum(new)/n
end

function pseudo_mont_carl(n)
s = SobolSeq(1)
eps2 = hcat([next(s) for i = 1:n]...)' + 1
# the generated numbers are between 1 and 2
G(x) = 4x^(-2)
new2 = zeros(n)
for i in 1:n
    new2[i] = G(eps2[i])
end
sum(new2)/n
end
print("")
println("")
print("The result (one draw) of the Pseudo Monte Carlo approximation of 2 is ", pseudo_mont_carl(n))
print("")
println("")
println("")
print("")
print("")


print("After taking a look at the demand functions, let us compare convergence of the two estimators as the number of points grows:")
fig = figure(figsize=(8,4)) 
m = 500
plut = zeros(m)
plat = zeros(m)
for i in 1:m
    plut[i] = mont_carl(i)
    plat[i] = pseudo_mont_carl(i)
end
plot(abs((plut) - 2),color="b",label="Monte-Carlo")
plot(abs((plat) - 2),color="r",label="Pseudo-Monte-Carlo")
title("Compared convergence of MC and PMC (1 iteration)")
ylabel("absolute deviation")
xlabel("number of points")
legend()
# Let's try to have an idea about how fast Monte-Carlo converges to 2 as we increase the number of iterations..
fig = figure(figsize=(8,4)) 
vector1 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,20,30,40,50,100,200,300,400,500,600,700,800,900,1000,1500,2000,2500,3000,5000,8000]
hello = zeros(length(vector1))
for j in vector1
iterations = j
    my_value = zeros(iterations)
        for i in 1:iterations
            my_value[i] = mont_carl(100)
        end
    hello[find(vector1 -> vector1 == j,vector1)] = abs(2 - (sum(my_value)/iterations))
end
plot(hello)
ylabel("absolute error")
xlabel("Number of iterations")
title("Convergence of Monte-Carlo (n = 100 points)")
print("")
println("")
	end


	function question_2a(n)
println("The eqm condition is h(p,t1,t2) = exp(t1)/p + exp(t2)/(p^{1.0/2.0}) - 2")
	end


	function question_2b(n)
println("I could not solve (only) the last question")
	end	


	# function to run all questions
	function runall(n=10)
		println("running all questions of HW-integration:")
		println("results of question 1:")
		question_1Aa(n)
		question_1Ba(n)	# make sure your function prints some kind of result!
		question_1Bb(n)
		question_1Bc(n)
		println("")
		println("results of question 2:")
		q2 = question_2a(n)
		println(q2)
		q2b = question_2b(n)
		println(q2b)
		println("end of HW-integration")
	end

end

