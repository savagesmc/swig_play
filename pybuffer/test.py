#!/usr/bin/env python3

import buffer

buf = bytearray(6)
buffer.snprintf(buf, "Hello world!")
print(buf)

size = 256
pybuf = bytearray(size)
for i in range(size):
    pybuf[i] = i

buf = buffer.Buffer()
buf.put(2*size)
buffer.write(pybuf, buf, size)

for i in range(2*size):
    print(f"{i} : {hex(buf[i])}")

