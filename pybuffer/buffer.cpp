#include "buffer.h"

namespace SwigPlay
{

int read(char* str, size_t size, Buffer& buffer)
{
  buffer.read(str, size);
  return 0;
}

int read2(char* str, size_t size, Buffer& buffer, size_t offset)
{
  buffer.read2(str, size, offset);
  return 0;
}

int write(char* str, size_t size, Buffer& buffer)
{
  buffer.write(str, size);
  return 0;
}

int write2(char* str, size_t size, Buffer& buffer, size_t offset)
{
  buffer.write2(str, size, offset);
  return 0;
}

}

