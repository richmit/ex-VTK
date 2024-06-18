#!/usr/bin/env -S ruby
# -*- Mode:ruby; Coding:us-ascii-unix; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      mk_vtk_image_STRUCTURED_POINTS.rb
# @author    Mitch Richling http://www.mitchr.me/
# @brief     Image data with VTK STRUCTURED_POINTS.@EOL
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

nx = 20
ny = 20
nz = 20

x0 = -5
y0 = -5
z0 = 0

sx = 0.1
sy = 0.1
sz = 0.1

sname = "example"

puts("# vtk DataFile Version 3.0")
puts("#{sname}")
puts("ASCII")
puts("DATASET RECTILINEAR_GRID")
puts("DIMENSIONS #{nx} #{ny} #{nz}")

puts("X_COORDINATES #{nx} float")
nx.times do |xi|
  x = xi*sx+x0
  print("#{x} ")
end
puts("")

puts("Y_COORDINATES #{ny} float")
ny.times do |yi|
  y = yi*sy+y0
  print("#{y} ")
end
puts("")

puts("Z_COORDINATES #{nz} float")
nz.times do |zi|
  z = zi*sz+z0
  print("#{z} ")
end
puts("")

puts("POINT_DATA #{nx*ny*nz}")
puts("SCALARS #{sname} float 1")
puts("LOOKUP_TABLE default")
daData = Array.new
nx.times do |xi|
  x = xi*sx+x0
  ny.times do |yi|
    y = yi*sy+y0
    nz.times do |zi|
      z = zi*sz+z0
      puts(Math::sqrt((x*x+y*y-x*y-x-z*z).abs))
    end
  end
end
