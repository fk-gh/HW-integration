

module IntTest
	using HW_int
	using FactCheck

	facts("testing demand function") do
        @fact  HW_int.y(1) --> 2 
    end

end 