#!/usr/bin/env -S ruby
# -*- Mode:ruby; Coding:us-ascii-unix; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      mk_vtk_surface_POLYDATA.rb
# @author    Mitch Richling http://www.mitchr.me/
# @brief     Surface data with VTK POLYDATA.@EOL
# @std       Ruby 3
# @copyright 
#  @parblock
#  Copyright (c) 2024, Mitchell Jay Richling <http://www.mitchr.me/> All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#
#  1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.
#
#  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.
#
#  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without
#     specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
#  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#  @endparblock
#########################################################################################################################################################.H.E.##

useTriangles = true

nx = 50
ny = 50

x0 = -5
y0 = -5

sx = 0.1
sy = 0.1

sname = "example"

puts("# vtk DataFile Version 3.0")
puts("#{sname}")
puts("ASCII")
puts("DATASET POLYDATA")
puts("POINTS #{nx*ny} float")
daData = Array.new
nx.times do |xi|
  x = xi*sx+x0
  ny.times do |yi|
    y = yi*sy+y0
    z = Math::sin(Math::sqrt(x*x+y*y))
    daData.push([x,y,z])
    puts("#{x} #{y} #{z}")
  end
end

if (useTriangles) then
  puts("POLYGONS #{2*(ny-1)*(nx-1)} #{2*4*(ny-1)*(nx-1)}")
  (nx-1).times do |xi|
    (ny-1).times do |yi|
      puts("3 #{xi*nx+yi} #{(xi+1)*nx+yi} #{(xi+1)*nx+(yi+1)}")
      puts("3 #{xi*nx+yi} #{(xi+1)*nx+(yi+1)} #{xi*nx+(yi+1)}")
    end
  end
else
  puts("TRIANGLE_STRIPS #{nx} #{2*ny*(nx-1)+(nx-1)}")
  (nx-1).times do |xi|
    print("#{2*ny}")
    ny.times do |yi|
      print(" #{xi*nx+yi} #{(1+xi)*nx+yi}")
    end
    puts("")
  end
end

puts("POINT_DATA #{daData.length}")
puts("scalars x float 1")
puts("LOOKUP_TABLE default")
daData.each do |x,y,z|
  puts("#{x}")
end
puts("scalars y float 1")
puts("LOOKUP_TABLE default")
daData.each do |x,y,z|
  puts("#{y}")
end
puts("scalars z float 1")
puts("LOOKUP_TABLE default")
daData.each do |x,y,z|
  puts("#{z}")
end
