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
#  Provide the filename as the first argument.  The next three arguments should be integers representing the columns with x, y, & z.
#  If the column numbers are not provided, the defaults are 1, 2, & 3.
#
#########################################################################################################################################################.H.E.##

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
desc = (ARGV[0] || puts("ERROR: Provide file name on command line followed by three column numbers") || exit)
cols = [(ARGV[1] || "1").to_i - 1, (ARGV[2] || "2").to_i - 1, (ARGV[3] || "3").to_i - 1]

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
points = Array.new
open(ARGV[0], "r") do |file|
  file.readline
  file.each_line do |line|
    points.push(line.chomp.split(',').values_at(*cols).map(&:to_f))
  end
end

#---------------------------------------------------------------------------------------------------------------------------------------------------------------
puts("<VTKFile type='UnstructuredGrid' version='0.1' byte_order='LittleEndian'>")
puts("<!-- #{desc} -->")
puts("  <UnstructuredGrid>")
puts("    <Piece NumberOfPoints='#{points.length}' NumberOfCells='#{points.length-1}'>")
puts("      <Points>")
puts("        <DataArray Name='Points' type='Float64' format='ascii' NumberOfComponents='3'>")
points.each do |p|
  puts("          #{p[0]} #{p[1]} #{p[2]}")
end
puts("        </DataArray>")
puts("      </Points>")
puts("      <Cells>")
puts("        <DataArray type='Int32' Name='connectivity' format='ascii'>")
1.upto(points.length-1) do |i|
  puts("          #{i-1} #{i}")
end
puts("        </DataArray>")
puts("        <DataArray type='Int32' Name='offsets' format='ascii'>")
print("          ")
1.upto(points.length-1) do |i|
  print("#{2*i} ")
end
puts("")
puts("        </DataArray>")
puts("        <DataArray type='Int8' Name='types' format='ascii'>")
puts("          " + ('3 ' * (points.length-1)))
puts("        </DataArray>")
puts("      </Cells>")
puts("    </Piece>")
puts("  </UnstructuredGrid>")
puts("</VTKFile>")

