--[[
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]
--Licensed under https://www.gnu.org/licenses/gpl-3.0.txt

--A Quaternion Library for Lua by https://github.com/Notsure45

local q = {}
q.__index = q;

function q.new(r,i,j,k)
  local self = {};
  setmetatable(self, q);
  self.r = r;
  self.i = i;
  self.j = j;
  self.k = k;
  return self;
end

function q.__add(a,b)
  if(getmetatable(a)~=q or getmetatable(b)~=q) then error("Quaternion addition only accepts other Quaternions!") end
  return(q.new(a.r+b.r,a.i+b.i,a.j+b.j,a.k+b.k))
end

function q.__sub(a,b)
  if(getmetatable(a)~=q or getmetatable(b)~=q) then error("Quaternion subtraction only accepts other Quaternions!") end
  return(q.new(a.r-b.r,a.i-b.i,a.j-b.j,a.k-b.k))
end

function q.__mul(a,b)
  if(getmetatable(a)~=q or getmetatable(b)~=q) and not(type(a)=="number" or type(b)=="number") then  end
  if(type(a)=="number") then
    return(q.new(a*b.r,a*b.i,a*b.j,a*b.k));
  elseif(type(b)=="number") then
    return(q.new(b*a.r,b*a.i,b*a.j,b*a.k));
  elseif(getmetatable(a)==q and getmetatable(b)==q) then
    return(q.new(
    a.r*b.r-a.i*b.i-a.j*b.j-a.k*b.k,
    a.r*b.i+a.i*b.r+a.j*b.k-a.k*b.j,
    a.r*b.j-a.i*b.k+a.j*b.r+a.k*b.i,
    a.r*b.k+a.i*b.j-a.j*b.i+a.k*b.r
    ));
  else
    error("Quaternion multiplcation only accepts Scalars and Quaternions! Got "..type(a).." and "..type(b));
  end
end


function q.conj(a) --Quaternion Conjugation
  return(q.new(a.r,-a.i,-a.j,-a.k));
end

function q.magnitude(a) --Gets the magnitude of a Quaternion
  return math.sqrt(math.pow(a.r,2)+math.pow(a.i,2)+math.pow(a.j,2)+math.pow(a.k,2));
end

function q.normalize(a) --Normalizes a Quaternion
  return a * ( 1/math.sqrt(math.pow(a.r,2)+math.pow(a.i,2)+math.pow(a.j,2)+math.pow(a.k,2)) );
end

function q.inverse(a) --Gets the inverse of a Quaternion
  return q.conj(a) * ( 1/(math.pow(a.r,2)+math.pow(a.i,2)+math.pow(a.j,2)+math.pow(a.k,2)) );
end

function q.rotateVQ(vector,rotQ) --Rotates a 3-vector [vector] using Quaternion [rotQ]
  local v = q.new(0,vector[1],vector[2],vector[3]);
  local vPrime = rotQ*v;
  vPrime = vPrime * q.conj(rotQ);
  return vPrime;
end

function q.toRotQ(angle, axis) --Returns the Rotation Quaternion from euler parameters: axis, and rotation about that axis
  local cF = math.sin(0.5*angle)/q.magnitude(q.new(0,axis[1],axis[2],axis[3]));
  return q.new(math.cos(0.5*angle),axis[1]*cF,axis[2]*cF,axis[3]*cF);
end

function q.vecToQ(vector, r) --Creates a quaternion with the imaginary part specified by vector and a real part of r
  return Q.new(r or 0,vector[1],vector[2],vector[3])
end

function q.getImag(a) --Returns the imaginary part as a vector
  return {a.i,a.j,a.k};
end

function q.serialize(a, round) --Returns a string in form: "w + x<i> + y<j> + z<k>". If specified, rounds to [round] amount of decimal places
  if round then
    local fct = math.pow(10,round);
    return math.floor((fct*a.r)+0.5)/fct.." + "..math.floor((fct*a.i)+0.5)/fct.."<i> + "..math.floor((fct*a.j)+0.5)/fct.."<j> + "..math.floor((fct*a.k)+0.5)/fct.."<k>"; 
  else
   return a.r.." + "..a.i.."<i> + "..a.j.."<j> + "..a.k.."<k>";
  end
end

return q;
