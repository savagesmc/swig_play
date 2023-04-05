#include "buffer.h"

namespace SwigPlay
{
int write(char* str, size_t size, Buffer& buffer, size_t offset)
{
  buffer.write(str, size, offset);
  return 0;
}
}

