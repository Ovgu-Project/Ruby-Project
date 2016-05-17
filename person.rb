require 'date'

class Person

	def initialize (id, name, salary, gender, position, hiredate, femaleHighSalary, femaleHiredate)
		@id = id
		@name = name
		@salary = salary
		@gender = gender
		@position = position
		@hiredate = hiredate
		@femaleHighSalary = femaleHighSalary
		@femaleHiredate = femaleHiredate	
	end
	
	# Function to get persons hired in the year 2014
	def getEmpList2014()
		empList = Array.new()
		puts ""
		puts "Generating List of Persons hired in the year 2014\n"
		count = @id.size
		yeartocompare = 2014
		if(count > 0)
			# Compare the @hiredate with year 2014 and generate a new list.
			while count > 0 do
				count = count-1		
				if Date.parse(@hiredate[count].to_s).year == yeartocompare
					empList.push(@id[count])
				end	
			end
		end
		return empList	
	end

	# Function to generate Male gender list.
	def getMaleList(empList2014)
		index = 0;
		count = 0;
		maleGenderList = Array.new()
		puts " "
		puts "Checking the Male Gender for the persons in the year 2014\n"
		# Filter the list 'empList2014' with gender 'M'.
		while count < empList2014.count
			index = (empList2014[count].to_i)-1
			case @gender[index]
			when "M"
				maleGenderList.push(index)
			end
			count = count+1
		end
		return maleGenderList
	end
  
	def getFemaleList(empList2014)
		index = 0;
		count = 0;
		femaleGenderList = Array.new()
		puts " "
		puts "Checking the Female Gender for the persons in the year 2014\n"
		# Filter the list 'empList2014' with gender 'M'.
		while count < empList2014.count
			index = (empList2014[count].to_i)-1
			case @gender[index]
			when "F"
				femaleGenderList.push(index)
			end
			count = count+1
		end
		return femaleGenderList
	end  

	# Function to select max salary of Men and Women
	def getTop10Salary(list2014)	
		i = 0
		max = 0;
		count = 0
		index = 0;		
		temp_index = 0		
		sal = Array.new();		
		empTop10List = Array.new()
		sal = @salary.dup
		# Loop to list 'list2014' and collect top 10 entries as per salary.
		while empTop10List.count < 10  do
			while count < list2014.count do 
				i = (list2014[count].to_i)
				if max <= sal[i].to_i
					max = sal[i].to_i
					index = i	
				end
				count = count+1;
			end
			# Set counter to zero if top 10 entries are not at found.	
			if (empTop10List.count != 10)&&(count == list2014.count)
				max = 0
				count = 0
			end
			# pust the index to empTop10List 			
			if index != temp_index
				empTop10List.push(index)
				sal[index] = "" 
				temp_index = index 
			end
		end
		return empTop10List		
	end
	
	# Function to display Name and Salary of top 10 Persons
	def getDisplayEmpDetails(list)
		index = 0
		count = 0
		puts ""
		# femaleHighSalary and femaleHiredate are used for getDate function
        if @gender[list[count].to_i] == "F"
            @femaleHighSalary = @salary[list[count].to_i]
            @femaleHiredate = @hiredate[list[count].to_i]
        end
        # Display the list with name and salary.
		while count < list.count
			index = list[count].to_i				
			puts "#{@name[index]}   ($#{@salary[index]})"
			count = count + 1
		end		
	end
 
	#Function to print details of Person for both the genders
	def PersonDetails()
		list2014 = getEmpList2014()						# Get the list of Employes from year 2014
		maleList2014 = getMaleList(list2014);			# Generate the list of Male employes from year 2014
		puts ""
		puts "Top Male List regarding salary\n"
		maleTop10List = getTop10Salary(maleList2014)	# Generate list of top 10 Male Employes from the year 2014
		getDisplayEmpDetails(maleTop10List)				# Display the result

		puts ""
		puts "Top Female List regarding salary\n"
		femaleList2014 = getFemaleList(list2014)		# Generate the list of Female Employes from year 2014
		femaleTop10List = getTop10Salary(femaleList2014)# Genrate list of top 10 Female Employes from year 2014
		getDisplayEmpDetails(femaleTop10List)			# Display the result.
	end	


	# Displays Hiredate for women with highest salary (with and without formater)
	def getDate(formater)
		puts ""
		date = ""
		date = Date.parse(@femaleHiredate.to_s)	# Parsing the date.
		if (formater)
			puts "With formater"
			puts "Hireddate of the woman with the highest salary of $#{@femaleHighSalary} :"
			puts "#{date.day}.#{date.month}.#{date.year}"
		else
			puts "Without formater"
			puts "Hireddate of the woman with the highest salary of $#{@femaleHighSalary} :"
			puts @femaleHiredate
		end
	end	
end