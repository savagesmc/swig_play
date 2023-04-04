#!/usr/bin/env python3

from buffer import Buffer
import numpy as np

size = 256

buf = Buffer()
buf.put(size)

a = np.arange(size, dtype=np.uint8)
b = a.tobytes()
buf.write(b)

for i in buf.getBufferSize():
    print(hex(buf[i]))

