#!/usr/bin/env -S ruby
# -*- Mode:ruby; Coding:us-ascii; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      curveCSVtoXML.rb
# @author    Mitch Richling http://www.mitchr.me/
# @date      2025-07-26
# @version   VERSION
# @brief     Read a CSV file with points, and produce a VTK VTU file with a curve.@EOL
# @std       Ruby 3
# @see       https://github.com/richmit/ex-VTK/
# @copyright 
#  @parblock
#  Copyright (c) 2025, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
#  
#  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#  
#  1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
#  
#  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.
#  
#  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software
#     without specific prior written permission.
#  
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
#  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
#  DAMAGE.
#  @endparblock
# @filedetails
#
#  Provide the filename as one argument.  The remaining arguments are of the form tag:c1[:c2[:c3[:c4]]].  One of the tags must be 'point' or 'points',
#  and it must contain three columns.  The remainder of the arguments describe point data.
#
#  One way to create an animation of curve evolution is to create time step vtu files:
#    sh  -c 'for f in $(seq 100 100 5000); do head -n $f lorenz.csv > $(printf "lorenz_%05d.csv" $f); done'
#    zsh -c 'for f in lorenz_*.csv(:r) ; do ./spaceCurveCSVtoXML.rb -v $f.csv points:3:4:5 > $f.vtu; done'
#
#########################################################################################################################################################.H.E.##

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
time = false
verbose = 0
fileToProcess = nil
sclData = Hash.new
vecData = Hash.new
pointCols = Array.new
ARGV.each do |arg|
  if (FileTest.exist?(arg)) then
    fileToProcess = arg
  elsif (tmp=arg.match(/^([^:]+):([0-9]+(:[0-9]+)*)$/)) then
    tag  = tmp[1]
    cols = tmp[2].split(':').map(&:to_i).map do |i| i-1; end
     if ((tag == 'point') || (tag == 'points')) then
       if (cols.length != 3) then
         STDERR.puts("ERROR: Points data must be 3 columns.  Arg invalid: #{arg}")
         exit
       end
       pointCols = cols
     else
       if (cols.length == 1) then
         sclData[tag] = cols.first
       else
         if (cols.length > 4) then
           STDERR.puts("ERROR: VTK only supports vectors of length 2-4.  Arg invalid: #{arg}")
           exit
         end
         vecData[tag] = cols
       end
     end
  elsif (arg.match(/^-+[hH]/)) then
    puts("USE")
    puts("  curveCSVtoXML.rb [options] <FILE_NAME> tag:c1[:c2[:c3[:c4]]]...")
    puts("  One of the 'tag' values must be 'point' with three columns")
    puts("OPTIONS")
    puts("  -verbose Turn on verbose reporting to STDOUT")
    puts("  -help    Print help mesage")
    puts("EXAMPLE")
    puts("  curveCSVtoXML.rb lorenz.csv point:3:4:5 't:2'")
    puts("")
    exit
  elsif (arg.match(/^-+[vV]/)) then
    verbose = 10
  else
    STDERR.puts("UNK: #{arg}")
    STDERR.puts("Run with -h argument for help")
    exit
  end
end

if (fileToProcess.nil?) then
  STDERR.puts("No file provided on command line!")
  STDERR.puts("Run with -h argument for help")
  exit
end

if ( pointCols.empty?) then
  pointCols = [0, 1, 2]
  if (verbose > 1) then
    STDERR.puts("Using default point columns!")
  end
end

[ ['x', 0], ['y', 1], ['z', 2]].each do |tag, col|
  if ( !(sclData.member?(tag))) then
    sclData[tag] = pointCols[col]
  end
end

if (verbose > 1) then
  STDERR.puts("File to process: #{fileToProcess.inspect}")
  STDERR.puts("Point cols: #{pointCols}")
  STDERR.puts("Scalar data: #{sclData.inspect}")
  STDERR.puts("Vector data: #{vecData.inspect}")
  STDERR.puts("Time mode: #{time.inspect}")
  STDERR.puts("Verbose mode: #{verbose.inspect}")
end

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
fileData = Array.new
open(fileToProcess, "r") do |file|
  file.readline
  file.each_line do |line|
    fileData.push(line.chomp.split(','))
  end
end

if (verbose > 1) then
  STDERR.puts("Found #{fileData.length} points in file")
end

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
puts("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='LittleEndian'>")
puts("<!-- #{fileToProcess} -->")
puts("  <UnstructuredGrid>")
puts("    <Piece NumberOfPoints='#{fileData.length}' NumberOfCells='#{fileData.length-1}'>")
sclDecl = ''
if ( !(sclData.empty?)) then
  sclDecl = "Scalars='" + sclData.keys.join(' ') + "'"
end
vecDecl = ''
if ( !(vecData.empty?)) then
  vecDecl = "Vectors='" + vecData.keys.join(' ') + "'"
end
puts("      <PointData #{sclDecl} #{vecDecl}>")
sclData.each do |tag, col|
  puts("        <DataArray Name='#{tag}' type='Float64' format='ascii' NumberOfComponents='1'>")
  print("          ")
  fileData.each do |d|
    print("#{d[col]} ")
  end
  puts("")
  puts("        </DataArray>")
end
vecData.each do |tag, col|
  puts("        <DataArray Name='#{tag}' type='Float64' format='ascii' NumberOfComponents='#{col.length}'>")
  fileData.each do |d|
    puts("          " + d.values_at(*col).join(' '))
  end
  puts("        </DataArray>")
end
puts("      </PointData>")
puts("      <Points>")
puts("        <DataArray Name='Points' type='Float64' format='ascii' NumberOfComponents='3'>")
fileData.each do |d|
  puts("          " + d.values_at(*pointCols).join(' '))
end
puts("        </DataArray>")
puts("      </Points>")
puts("      <Cells>")
puts("        <DataArray type='Int32' Name='connectivity' format='ascii'>")
1.upto(fileData.length-1) do |i|
  puts("          #{i-1} #{i}")
end
puts("        </DataArray>")
puts("        <DataArray type='Int32' Name='offsets' format='ascii'>")
print("          ")
1.upto(fileData.length-1) do |i|
  print("#{2*i} ")
end
puts("")
puts("        </DataArray>")
puts("        <DataArray type='Int8' Name='types' format='ascii'>")
puts("          " + ('3 ' * (fileData.length-1)))
puts("        </DataArray>")
puts("      </Cells>")
puts("    </Piece>")
puts("  </UnstructuredGrid>")
puts("</VTKFile>")





