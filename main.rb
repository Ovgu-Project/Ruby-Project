#!/usr/bin/ruby -w

require './person'
require 'rexml/document'
require 'date'
include REXML
	
	# Function to parse given xml tree.	
	def parsexml(path)
		# Array for parsing XML tree
		id = Array.new()
		name = Array.new()
		gender = Array.new()
		salary = Array.new()
		hiredate = Array.new()
		position = Array.new()
		date =  Array.new()
		femaleHighSalary = 0.0
		femaleHiredate = ""

		
		puts "Parsing XML file"
		xmlfile = File.new(path)
		xmldoc = Document.new(xmlfile)
   
		# Parse id from xml file.
		puts "   Row indexes.. "	   
		xmldoc.elements.each("response/row/row"){ 
			|e| id.push(e.attributes["_id"])    
		}
		
		# Parse name from xml file.
		puts "   Name.. "		   
		xmldoc.elements.each("response/row/row/full_name") {
			|e| name.push(e.text)   
		}
		
		# Parse salary from xml file.
		puts "   Salary.. "
		xmldoc.elements.each("response/row/row/current_annual_salary") {	  
			|e| salary.push(e.text) 
		}
		
		# Parse gender from xml file.
		puts "   Gender.. "			
		xmldoc.elements.each("response/row/row/gender") {
			|e| gender.push(e.text) 
		}
		
		# Parse position from xml file.
		puts "   Position.. "	
		xmldoc.elements.each("response/row/row/position_title") { 
			|e| position.push(e.text) 
		}
			
		# Parse hiredate from xml file.
		puts "   Hired Date.. "	   
		xmldoc.elements.each("response/row/row/date_first_hired") {  
			|e| hiredate = e.text
			date.push(checkDate(hiredate))
		}
		
		person = Person.new(id, name, salary, gender, position, date, femaleHighSalary, femaleHiredate)
		person.PersonDetails
		person.getDate(nil)
		person.getDate(formater="")
		
	end
	
	# Function to parse hiredate.
	def checkDate(emp_hired_date)
		date = Date.parse(emp_hired_date)
		return date		
	end
	
	
	
	# Invoking function to parse the xml tree
	parsexml("XMLfile.xml")
