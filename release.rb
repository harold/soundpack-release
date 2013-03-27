require 'set'
require 'fileutils'

if ARGV.empty? then puts "enter a pack number to release"; exit end
n = ARGV[0]

print "prepare sound pack #{n} for release? (y/n) "

response = STDIN.gets.chomp

if "y" == response then
	dir_name = Dir["../#{n}*"].first
	file_names = Dir["#{dir_name}/*"]

	free_dir_name = dir_name + " - free"
	FileUtils::rm_rf free_dir_name
	Dir::mkdir free_dir_name

	random_numbers = Set.new
	while random_numbers.length < 10
		r = rand 100
		random_numbers << r
	end

	random_numbers.each do |i|
		puts "copying: #{file_names[i]} #{free_dir_name}"
		FileUtils::cp file_names[i], free_dir_name
	end

	support_dir_name = dir_name + " - support files"
	FileUtils::rm_rf support_dir_name
	Dir::mkdir support_dir_name
	puts "writing filenames markdown file"
	File.open( support_dir_name+"/filenames.txt", 'w' ) do |f|
		file_names.each do |n|
			f.puts "- "+n[/[^\/]+$/]
		end
	end
end
