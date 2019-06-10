# Quaternion.lua

### Rotations Simplified

An Explination of Quaternions: http://mathworld.wolfram.com/Quaternion.html

`q.new(r,i,j,k)` Creates a new Quaternion with real part [r] and imaginary parts [i], [j] and [k]

`q.__add(a,b)` Metamethod for adding two Quaternions

`q.__sub(a,b)` Metamethod for subtracting two Quaternions

`q.__mul(a,b)` Metamethod for multiplying two quaternions

`q.conj(a)` Quaternion Conjugation

`q.magnitude(a)` Gets the magnitude of a Quaternion

`q.normalize(a)` Normalizes a Quaternion to a magnitude of 1

`q.inverse(a)` Gets the (multiplicative) inverse of a Quaternion

`q.rotateVQ(vector,rotQ)` Rotates a 3-vector [vector] using Quaternion [rotQ]

`q.toRotQ(angle, axis)` Returns the Rotation Quaternion from euler parameters: axis, and rotation about that axis

`q.vecToQ(vector, r)` Creates a Quaternion with the imaginary part specified by [vector] and with a real part of [r]

`q.getImag(a)` Returns the imaginary part of a Quaternion as a 3-vector

`q.serialize(a, round)` Returns a string in form: "w + x<i> + y<j> + z<k>". If specified, rounds to [round] amount of decimal places
