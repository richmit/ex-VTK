#!/usr/bin/env -S ruby
# -*- Mode:ruby; Coding:us-ascii-unix; fill-column:158 -*-
#########################################################################################################################################################.H.S.##
##
# @file      mk_vtk_curve_STRUCTURED_GRID.rb
# @author    Mitch Richling http://www.mitchr.me/
# @brief     Curve data with VTK STRUCTURED_GRID.@EOL
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

nt = 100

t0 = -7

st = 0.1

sname = "example"

puts("# vtk DataFile Version 3.0")
puts("#{sname}")
puts("ASCII")
puts("DATASET STRUCTURED_GRID")
puts("DIMENSIONS #{nt} 1 1")

puts("POINTS #{nt} float")
daData = Array.new
nt.times do |ti|
  t = ti*st+t0
  x = Math::cos(t)
  y = Math::sin(t)
  z = t
  daData.push([t,x,y,z])
  puts("#{x} #{y} #{z}")
end

puts("POINT_DATA #{daData.length}")
puts("SCALARS t float 1")
puts("LOOKUP_TABLE default")
daData.each do |t,x,y,z|
  puts("#{t}")
end
puts("SCALARS x float 1")
puts("LOOKUP_TABLE default")
daData.each do |t,x,y,z|
  puts("#{x}")
end
puts("SCALARS y float 1")
puts("LOOKUP_TABLE default")
daData.each do |t,x,y,z|
  puts("#{y}")
end
puts("SCALARS z float 1")
puts("LOOKUP_TABLE default")
daData.each do |t,x,y,z|
  puts("#{z}")
end

