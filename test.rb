var1 = { "a" => 3, "b" => 45 }
puts var1

puts var1["a"]
puts var1[0]
var2 = gets.chomp


def dostuff(input)
	var = input.to_i * 4
	var

end

puts dostuff(var2)

var3 = [4, 5, 6, 7, 8]

var3.each do |inword|
	puts dostuff(inword)

end